//
//  ViewModelProtocol .swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/8/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

protocol ArticleFeedProviding: class {
    
    var continent: Continent { get }
    var dataController: DataController { get }
    var articles: [Article] { get set }
    
    var numberOfArticles: Int { get }
    func articleTitle(index: Int) -> String
    func articleimageURL(index: Int) -> String
    func articlePublishDate(index: Int) -> String
    
    func makeADetailViewModel(withModelAtIndex index: Int) -> DetailArticleViewModel
    
    func getArticlesFromCache(completion: @escaping (Error?) -> Void)
    func getArticlesFromNetwork(completion: @escaping (Error?) -> Void)
    
    init(continent: Continent)
    
}

extension ArticleFeedProviding {
    
    func getArticlesFromCache(completion: @escaping (Error?) -> Void) {
        
        self.dataController.loadFromCache(resource: Article.createResourceForContinent(continent:continent)) { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                case .success(let values):
                    self?.articles = values
                    completion(nil)
                case .fail(let error):
                    print("\(error.localizedDescription)")
                    completion(error)
                }
            }
        }
        
    }
    
    func getArticlesFromNetwork(completion: @escaping (Error?) -> Void) {
        let resource = Article.createResourceForContinent(continent: continent)
        
        self.dataController.loadFromNetwork(resource: resource) { [weak self]
            result in
            DispatchQueue.main.async {
                switch result {
                case .success(let values):
                    self?.articles = values
                    
                    print("\(String(describing: self?.articles))")
                    completion(nil)
                case .fail(let error):
                    print(error)
                    completion(error)
                }
            }
        }
    }
    
    func makeADetailViewModel(withModelAtIndex index: Int) -> DetailArticleViewModel {
        let articleToPass = self.articles[index]
        return DetailArticleViewModel(article: articleToPass)
    }
}
