//
//  Article.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/7/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

struct Article: Codable {

    struct Source: Codable {
        let source: String
        enum CodingKeys: String, CodingKey{
            case source = "name"
        }
    }

    let author: String?
    let title: String
    let description: String
    let imageURLString: String
    let URLString: String
    let publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case imageURLString = "urlToImage"
        case URLString = "url"
        case publishedAt
    }
}


enum Continent: Int, CaseIterable {
    case africa
    case asia
    case northAmerica
    case southAmerica
    case europeAndAustralia
}

extension Continent {

    var resourceParameter: String  {
        switch self {

        case .northAmerica:
            return "North%20America"

        case .southAmerica:
            return "South%20America"

        case .europeAndAustralia:
            return "Europe%20Australia"

        case .africa:
            return "Africa"

        case .asia:
            return "Asia"
        }
    }

    var displayTitle: String  {
        switch self {

        case .northAmerica:
            return "North America"

        case .southAmerica:
            return "South America"

        case .europeAndAustralia:
            return "Europe & Australia"

        case .africa:
            return "Africa"

        case .asia:
            return "Asia"
        }
    }

    var tabIndex: Int {
        return self.rawValue
    }

}

extension Article {

    static func decodeArticleBox(data: Data) -> ArticleBox? {
        return Resource<ArticleBox>.decode(data: data)
    }
}

public struct ArticleBox: Codable {

    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case articles = "articles"
    }

}
