//
//  ArticleTableViewCell.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 3/28/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import UIKit

final class ArticleTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // We always want to use the subtitle style for this cell, until we have a different design
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
