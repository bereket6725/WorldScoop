//
//  Article.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/7/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

struct Article: Codable {
    let source: String
    let author: String
    let title: String
    let description: String
    let imageURLString: URL
    let URLString: URL
    let publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        case source = "name"
        case author
        case title
        case description
        case imageURLString = "urlToImage"
        case URLString = "url"
        case publishedAt
    }
}

enum Continent {
    case NorthAmerica
    case SouthAmerica
    case EuropeAndAustralia
    case Africa
    case Asia
}

extension Article {
    //
    
}

public struct ArticleBox: Codable {
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case articles = "data"
    }
}
