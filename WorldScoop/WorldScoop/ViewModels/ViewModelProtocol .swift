//
//  ViewModelProtocol .swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/8/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

protocol ArticleFeedProviding {
    
    var numberOfArticles: Int { get }
    func articleTitle(index: Int) -> String
    func articleimageURL(index: Int) -> String
    func articlePublishDate(index: Int) -> String
    
    func makeADetailViewModel(withModelAtIndex index: Int) -> DetailArticleViewModel
    
    func getArticlesFromCache(completion: @escaping (Error?) -> Void)
    func getArticlesFromNetwork(completion: @escaping (Error?) -> Void)
    
}
