//
//  ContinentNewsViewController.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/8/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import UIKit
import SafariServices

final class ContinentNewsViewController: UIViewController {

    lazy var viewModel: ArticleListViewModel = {
        return ArticleListViewModel(continent: self.currentContinent)
    }()
    
    var dataSource: TableViewDataSource?
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Tint color gets reset every time we change tabs, so reset it here
        self.resetTabBarColor()
    }

}

extension ContinentNewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = viewModel.articleURL(index: indexPath.row)
        self.openArticle(url: url)
    }

}

private extension ContinentNewsViewController  {

    func setup() {
        self.setupNavigationBar()
        self.setupTableView()
        self.getArticles()
    }

    func setupNavigationBar() {
        self.navigationItem.title = self.currentContinent.displayTitle
        self.navigationController?.navigationBar.barTintColor = self.currentContinent.color
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font : UIFont.boldSystemFont(ofSize: 21.0),
            .foregroundColor : UIColor.white
        ]
    }

    func getArticles() {
        // 1. First from cache to get the last saved content
        self.viewModel.getArticlesFromCache { error in
            if let error = error {
                print(error)
            } else {
                self.tableView.reloadData()
            }

            // 1. We do this inside of the completion block because we want to avoid a possible race condition
            // This would be more composable and look nicer with Promises, but I didn't want to add an external dependency
            
            // 2. Then from the network to get the latest content
            self.viewModel.getArticlesFromNetwork(completion: { error in
                if let error = error {
                    print(error)
                } else {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    func setupTableView() {
        self.view.addSubview(self.tableView)

        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        let reuseIdentifier = ArticleTableViewCell.self.description()
        self.dataSource = TableViewDataSource.create(with: viewModel, reuseIdentifier: reuseIdentifier)

        self.tableView.delegate = self
        self.tableView.allowsSelection = true
        self.tableView.dataSource = dataSource
        self.tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    func resetTabBarColor() {
        let currenTabBarImage = self.tabBarItem.image
        self.tabBarController?.tabBar.tintColor = self.currentContinent.color
        self.tabBarItem.image = currenTabBarImage?.withRenderingMode(.alwaysTemplate)
    }

    func openArticle(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredBarTintColor = self.currentContinent.color
        safariViewController.preferredControlTintColor = UIColor.white

        self.present(safariViewController, animated: true, completion: nil)
    }

    var currentContinent: Continent {
        // All of the tabs hold navigation controllers, but we want their view controllers
        guard let navigationControllers: [UINavigationController] = self.tabBarController?.viewControllers as? [UINavigationController] else { return Continent.allCases[0] }
        let viewControllers = navigationControllers.map({ $0.topViewController })

        // The current tab is the one where our view controller is the one that is self in the array of view controllers
        guard let currentTab = viewControllers.firstIndex(of: self) else { return Continent.allCases[0] }

        return Continent.allCases[currentTab]
    }

}

// In this file because it is only a concern of the view controller, where we are rendering this UI.
// We can move it somewhere else if we find more places that we can use color.
private extension Continent {

    var color: UIColor  {
        switch self {

        case .africa:
            return UIColor(red: 0.796, green: 0.776, blue: 0.655, alpha: 1.0)

        case .asia:
            return UIColor(red: 0.49, green: 0.655, blue: 0.565, alpha: 1.0)

        case .northAmerica:
            return UIColor(red: 0.376, green: 0.78, blue: 0.973, alpha: 1.0)

        case .southAmerica:
            return UIColor(red: 0.737, green: 0.416, blue: 0.263, alpha: 1.0)

        case .europeAndAustralia:
            return UIColor(red: 0.675, green: 0.294, blue: 0.322, alpha: 1.0)

        }
    }

}
