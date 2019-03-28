//
//  ContinentNewsViewController.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/8/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import UIKit

final class ContinentNewsViewController: UIViewController {

    lazy var viewModel: ArticleListViewModel = {
        return ArticleListViewModel(continent: self.currentContinent)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tint color gets reset every time
        self.resetTabBarColor()
    }

    func resetTabBarColor() {
        let currenTabBarImage = self.tabBarItem.image
        self.tabBarController?.tabBar.tintColor = self.currentContinent.color
        self.tabBarItem.image = currenTabBarImage?.withRenderingMode(.alwaysTemplate)
    }

}

private extension ContinentNewsViewController {

    func setup() {
        self.setupNavigationBar()

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
        self.viewModel.getArticlesFromNetwork { (error) in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
    }

}

private extension ContinentNewsViewController {

    var currentContinent: Continent {
        // All of the tabs hold navigation controllers, but we want their view controllers
        guard let navigationControllers: [UINavigationController] = self.tabBarController?.viewControllers as? [UINavigationController] else { return .northAmerica }
        let viewControllers = navigationControllers.map({ $0.topViewController })

        // The current tab is the one where our view controller is the one that is self in the array of view controllers
        guard let currentTab = viewControllers.firstIndex(of: self) else { return .northAmerica }

        return Continent.allCases[currentTab]
    }
}

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
