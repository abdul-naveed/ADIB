//
//  ArticleDetailViewController.swift
//  Articles
//
//  Created by AbdulNaveed Soudagar on 08/11/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    // Abstract label
    @IBOutlet weak var abstractLabel:UILabel!
    
    // Source Label
    @IBOutlet weak var sourceLabel:UILabel!
    
    // View Modal
    var articleViewModal:PopularArticlesViewModel?
    
    // Represented View Index
    var index:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModal = articleViewModal,let idx = index {
            viewModal.configureView(index: idx, vc: self)
        }
    }
}

extension PopularArticlesViewModel {
    func configureView(index:Int, vc:ArticleDetailViewController) {
        let representedArticleModal = self.popularArticles?[index]
        if let modal = representedArticleModal {
            vc.navigationItem.title = modal.title
            vc.abstractLabel.text = modal.abstract
            vc.sourceLabel.text = modal.source
        }
    }
}
