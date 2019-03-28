//
//  ArticleListViewModel.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/8/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation

struct ArticleListTableView {
    static let reuseID = "reuseID"
    static let cellNibName = "ArticleTableViewCell"
    static let storyBoardName = "Main"
    static let detailStoryBoardID = "DetailView"
}


final class ArticleListViewModel: NSObject, ArticleFeedProviding {
    var dataController: DataController

    var continent: Continent
    
    var articles: [Article] = []
    
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
    
    init(continent: Continent) {
        dataController = DataController()
        self.continent = continent
        super.init()
    }
    
}
