//
//  DataController.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/7/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

struct DataController {
    
    let networker = NetworkController()
    let cache = CacheController()
    
    func loadFromCache<A: Codable>(resource: Resource<A>, update: @escaping (Result<A>) -> Void) {
        guard let cachedResult = cache.load(resource: resource) else {
            let appError = ApplicationError.couldNotLoadFromNetwork("no data to load from cache")
            print("\(appError.localizedDescription)")
            update(Result.fail(appError))
            return
        }
        update(Result.success(cachedResult))
    }
    
    func loadFromNetwork<A: Codable>(resource: Resource<A>, update: @escaping (Result<A>) -> Void) {
        // We make a new data resource since the other will turn our data into json.
        let dataResource = Resource<Data>(url: resource.url, parser: {$0})
        
        self.networker.load(resource: dataResource, completion: { data in
            
            switch data {
            case .success(let data):
                
                self.cache.save(value: data, for: resource)
                
                guard let result = resource.parser(data) else { return }
                            
                print("\(result)")
                update(Result.success(result))
            case .fail(let appError):
                print("\(appError.localizedDescription)")
                update(Result.fail(appError))
            }
        })
    }
}
