//
//  DataSource.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/9/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import Foundation
import UIKit

final class TableViewDataSource: NSObject, UITableViewDataSource {

    typealias CellConfigurator = (ArticleListViewModel, ArticleTableViewCell, Int) -> Void

    var viewModel: ArticleListViewModel
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(viewModel: ArticleListViewModel, reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.viewModel = viewModel
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? ArticleTableViewCell else { fatalError("Could not dequeue cell") }

        cellConfigurator(viewModel, cell, indexPath.row)

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

// A nice convenience method that will make the creation of our dataSource look cleaner.
// Also a better separation of concerns.
extension TableViewDataSource {
    
    static func create(with viewModel: ArticleListViewModel, reuseIdentifier: String) -> TableViewDataSource {
        return TableViewDataSource(viewModel: viewModel, reuseIdentifier: reuseIdentifier, cellConfigurator: { (viewModel, cell, index) in
            cell.textLabel?.text = viewModel.articleTitle(index: index)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)

            cell.detailTextLabel?.text = viewModel.articlePublishDate(index: index)
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        })
    }

}
