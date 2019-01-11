//
//  AsiaViewModel.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/9/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

final class AsiaViewModel: NSObject, ArticleFeedProviding {

    var continent: Continent
        
    var articles: [Article] = []
    internal let dataController = DataController()
    
    var numberOfArticles: Int {
        return articles.count
    }
    
    func articleTitle(index: Int) -> String {
        return articles[index].title
    }
    
    func articleimageURL(index: Int) -> String {
        return articles[index].imageURLString
    }
    
    func articlePublishDate(index: Int) -> String {
        return articles[index].publishedAt
    }
    
//    func getArticlesFromCache(completion: @escaping (Error?) -> Void) {
//
//        dataController.loadFromCache(resource: Article.createResourceForContinent(continent: continent)) { [weak self]  result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let values):
//                    self?.articles = values
//                    completion(nil)
//                case .fail(let error):
//                    print("\(error.localizedDescription)")
//                    completion(error)
//                }
//            }
//        }
//
//    }
//
//    func getArticlesFromNetwork(completion: @escaping (Error?) -> Void) {
//
//        dataController.loadFromNetwork(resource: Article.createResourceForContinent(continent: continent)) { [weak self]  result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let values):
//                    self?.articles = values
//                    print("\(String(describing: self?.articles))")
//                    completion(nil)
//                case .fail(let error):
//                    print(error)
//                    completion(error)
//                }
//            }
//        }
//    }
//
//    func makeADetailViewModel(withModelAtIndex index: Int) -> DetailArticleViewModel {
//        let articleToPass = self.articles[index]
//        return DetailArticleViewModel(article: articleToPass)
//    }
    
    init(continent: Continent){
        self.continent = continent
    }
}
