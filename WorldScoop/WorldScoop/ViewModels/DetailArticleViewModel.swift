//
//  DetailArticleViewModel.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/8/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

struct DetailArticleViewModel {
    
    var article: Article
    
    var title: String {
        return self.article.title
    }
    
    var imageURL: URL {
        return URL(string: self.article.imageURLString)!
    }
    
    var datePublished: String {
        return self.article.publishedAt
    }
    
    init(withArticle article: Article) {
        self.article = article
    }
    
}
