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

extension Continent {
    var resourceParameter:  String  {
        switch self {
        case .NorthAmerica:
            return "North%20America"
        case .SouthAmerica:
            return "South%20America"
        case .EuropeAndAustralia:
            return "Europe%20Australia"
        case .Africa:
            return "Africa"
        case .Asia:
            return "Asia"
        }
    }
}

extension Article {

    static func createResourceForContinent(continent: Continent) -> Resource<[Article]> {
        let continentArticles =  Resource<[Article]>(url: URL(string:"https://newsapi.org/v2/everything?q=" + continent.resourceParameter + "&apiKey=a142ef71f0b14587b7dc712813539711")!, parser: { data in
             return  Article.decodeArticleBox(data: data)?.articles
        })
        return continentArticles
    }
    
    static func decodeArticleBox(data: Data) -> ArticleBox? {
        return Resource<ArticleBox>.decode(data: data)
    }
}

public struct ArticleBox: Codable {
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case articles = "data"
    }
}
