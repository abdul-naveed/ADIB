//
//  ViewModel.swift
//  Articles
//
//  Created by AbdulNaveed Soudagar on 14/11/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import Foundation
import UIKit

class PopularArticlesViewModel {
    
    var popularArticles:[Article]? = nil
    
    func getArticles(days:Int, completionHandler: @escaping articlesCompletion)  {
        ArticlesManager.getMostPopularArticles(days: days) { (resultList, error) in
            guard let responseList = resultList else {
                return
            }
            self.popularArticles = responseList
            completionHandler(responseList,nil)
        }
    }
    
    // Function to update on UI
    func configureRowView(articleRow:Int, view:ArticleRowViewCell) {
        let articalModal = popularArticles?[articleRow];
        if let title = articalModal?.title {
            view.titleLabel.text = title
        }
        
        if let byline = articalModal?.byline {
            view.byLineLabel.text = byline
        }
        
        if let date = articalModal?.date {
            view.dateLabel.text = date
        }
    }
}
