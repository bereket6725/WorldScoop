//
//  CacheController.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/7/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

struct CacheController {
    
    private let baseURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    func load<A: Codable>(resource: Resource<A>) -> A? {
        guard let url = baseURL?.appendingPathComponent(resource.cacheKey) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return Resource<A>.decode(data: data)
    }
    
    @discardableResult
    func save<A: Codable>(value: Data, for resource: Resource<A> ) -> Bool {
        guard let url = baseURL?.appendingPathComponent(resource.cacheKey) else { return false }
        guard let response = resource.parser(value) else { return false }
        do {
            let encoded =  try JSONEncoder().encode(response)
            if let _ = try? encoded.write(to: url) {
                print("saved data")
                print("\(resource.cacheKey)")
                return true
            }
            return false
        } catch {
            print("\(error.localizedDescription)")
            return false
        }
    }
}
