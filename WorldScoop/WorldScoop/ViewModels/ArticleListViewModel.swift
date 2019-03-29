//
//  ArticleListViewModel.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/8/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation


final class ArticleListViewModel: NSObject { //, ArticleFeedProviding {

    var articles: [Article] = []
    
    let dataController = DataController()
    let continent: Continent
    
    var numberOfArticles: Int {
        return articles.count
    }
    
    func articleTitle(index: Int) -> String {
        return articles[index].title
    }
    
    func articleImageURL(index: Int) -> String {
        return articles[index].imageURLString
    }

    func articleURL(index: Int) -> URL {
        return URL(string: articles[index].URLString)!
    }

    func articlePublishDate(index: Int) -> String {
        let originalDateString = articles[index].publishedAt

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy, h:mm a"

        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: originalDateString)

        if let parsedDate = date {
            return dateFormatter.string(from: parsedDate)
        } else {
            return originalDateString
        }
    }

    init(continent: Continent) {
        self.continent = continent
        super.init()
    }

    func getArticlesFromCache(completion: @escaping (Error?) -> Void) {
        let resource =  Resource<Article>.articleResource(continent: self.continent)

        self.dataController.loadFromCache(resource: resource) { [weak self]  result in
            DispatchQueue.main.async {
                switch result {

                case .success(let values):
                    self?.articles = values
                    completion(nil)

                case .failure(let error):
                    print("\(error.localizedDescription)")
                    completion(error)

                }
            }
        }
    }

    func getArticlesFromNetwork(completion: @escaping (Error?) -> Void) {
        let resource =  Resource<Article>.articleResource(continent: self.continent)

        self.dataController.loadFromNetwork(resource: resource) { [weak self] result in
            DispatchQueue.main.async {
                switch result {

                case .success(let values):
                    self?.articles = values

                    print("\(String(describing: self?.articles))")
                    completion(nil)

                case .failure(let error):
                    print(error)
                    completion(error)
                }
            }
        }
    }

}

private extension Resource {

    static func articleResource(continent: Continent) -> Resource<[Article]> {
        let url = URL(string:"https://newsapi.org/v2/everything?q=" + continent.resourceParameter + "&apiKey=a142ef71f0b14587b7dc712813539711")!

        let continentArticles = Resource<[Article]>(url:url, parser: { data in
            return Article.decodeArticleBox(data: data)?.articles
        })

        return continentArticles
    }

}
