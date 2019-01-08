//
//  ErrorHandling.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/7/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

public enum Result<A> {
    case success(A)
    case fail(ApplicationError)
}

public enum ApplicationError: Error {
    case noResponse(String)
    case couldNotLoadFromNetwork(String)
    case couldNotLoadFromCache(String)
    case couldNotParse(String)
    case other(String)
}
