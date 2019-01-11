//
//  SouthAmericaViewController.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/8/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import UIKit

class SouthAmericaViewController: UIViewController {
    var viewModel =  ArticleListViewModel(continent: .SouthAmerica)

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getArticlesFromNetwork { (error) in
            if let error = error {
                print("\(error.localizedDescription)")
            }

        }
        print("\(viewModel.numberOfArticles)")

        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
