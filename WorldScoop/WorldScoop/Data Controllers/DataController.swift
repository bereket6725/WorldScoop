//
//  DataController.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/7/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

struct DataController {
    
    private let networkController = NetworkController()
    private let cache = CacheController()
    
    func loadFromCache<A: Codable>(resource: Resource<A>, update: @escaping (Result<A>) -> Void) {
        guard let cachedResult = cache.load(resource: resource) else {
            let appError = ApplicationError.couldNotLoadFromNetwork("no data to load from cache")
            print("\(appError.localizedDescription)")
            update(Result.failure(appError))
            return
        }

        update(Result.success(cachedResult))
    }
    
    func loadFromNetwork<A: Codable>(resource: Resource<A>, update: @escaping (Result<A>) -> Void) {
        // We make a new data resource since the other will turn our data into json.
        let dataResource = Resource<Data>(url: resource.url, parser: {$0})
        
        self.networkController.load(resource: dataResource, completion: { data in
            switch data {

            case .success(let data):
                self.cache.save(value: data, for: resource)
                
                guard let result = resource.parser(data) else { return }
                            
                print("\(result)")
                update(Result.success(result))

            case .failure(let appError):
                print("\(appError.localizedDescription)")
                update(Result.failure(appError))

            }
        })
    }
}
