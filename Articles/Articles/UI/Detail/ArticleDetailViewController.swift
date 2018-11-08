//
//  ArticleDetailViewController.swift
//  Articles
//
//  Created by AbdulNaveed Soudagar on 08/11/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    // Represented Model
    var representedArticleModel:Article?
    
    // Abstract label
    @IBOutlet weak var abstractLabel:UILabel!
    
    // Source Label
    @IBOutlet weak var sourceLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = representedArticleModel?.title
        self.abstractLabel.text = representedArticleModel?.abstract
        self.sourceLabel.text = representedArticleModel?.source
    }

}
