//
//  ArticleTableViewCell.swift
//  WorldScoop
//
//  Created by Bereket Ghebremedhin  on 3/28/19.
//  Copyright © 2019 Bereket Ghebremedhin . All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var articleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
