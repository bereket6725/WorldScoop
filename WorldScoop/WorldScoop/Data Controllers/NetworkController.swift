//
//  NetworkController.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/7/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

//Makes requests to get data from Grailed's server that will be passed into the parse function of our resource.
struct NetworkController {
    
    func load <A>(resource: Resource<A>, completion: @escaping (Result<A>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) {(data, _, _) in
            //Data might be nil and and the resource that parses it might be nil, flatmap does one level of unwrapping,
            //so we dont get an optional wrapped in another optional.
            guard let result = data.flatMap(resource.parser) else {
                
                let appError = ApplicationError.couldNotParse("could not parse")
                completion(Result.fail(appError))
                return
            }
            completion(Result.success(result))
        }
        task.resume()
    }
}
