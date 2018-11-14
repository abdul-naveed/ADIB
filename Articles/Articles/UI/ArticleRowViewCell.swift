//
//  ArticleRowViewCell.swift
//  Articles
//
//  Created by AbdulNaveed Soudagar on 08/11/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit

class ArticleRowViewCell: UITableViewCell {

    // Title Label
    @IBOutlet weak var titleLabel:UILabel!
    
    // By Line
    @IBOutlet weak var byLineLabel:UILabel!
    
    // Published Date
    @IBOutlet weak var dateLabel:UILabel!
    
    // Article Image
    @IBOutlet weak var imageLabel:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageLabel.layer.borderWidth = 1
        imageLabel.layer.masksToBounds = false
        imageLabel.layer.borderColor = UIColor.black.cgColor
        imageLabel.layer.cornerRadius = imageLabel.frame.height/2
        imageLabel.clipsToBounds = true
    }
}
