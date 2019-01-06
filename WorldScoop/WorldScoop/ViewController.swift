//
//  ViewController.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 1/6/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let apiKey = "a142ef71f0b14587b7dc712813539711"
        // Do any additional setup after loading the view, typically from a nib.
        requestNewsAPI()
    }
    
    func requestNewsAPI(){
        var request = URLRequest(url: URL(string:"https://newsapi.org/v2/everything?q=africa&apiKey=a142ef71f0b14587b7dc712813539711")!)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) {(data, _, _) in
            guard let data = data else {
                print("couldnt get data")
                return
            }
            print("\(data)")
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let json = json {
                print("\(json)")
            }
        }
        task.resume()
    }
}

