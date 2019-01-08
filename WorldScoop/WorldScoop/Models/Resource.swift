//
//  Resource.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/7/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

struct Resource<A: Decodable> {
    let url: URL
    let parser: (Data) -> A?
    
    init(url: URL, parser: @escaping (Data) -> A?) {
        self.url = url
        self.parser = parser
    }
    
    static func decode(data: Data) -> A? {
        let decoder = JSONDecoder()
        return try? decoder.decode(A.self, from: data)
    }
    
}

extension Resource {
    var cacheKey: String {
        // Since we are caching to disk, we are removing any characters that are not file system safe.
        return url.absoluteString
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: ":", with: "_")
            .replacingOccurrences(of: ".", with: "_")
    }
}
