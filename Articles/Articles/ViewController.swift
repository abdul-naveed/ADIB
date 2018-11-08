//
//  ViewController.swift
//  Articles
//
//  Created by AbdulNaveed Soudagar on 08/11/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Represented Article List
    fileprivate var articleList:[Article]? = []
    
    // Table View
    @IBOutlet weak var tableView:UITableView!
    
    // Refresh Controller
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureListView()
        self.refreshViewController()
    }
    
    @objc private func refreshViewController() {
        
        if(self.refreshControl.isRefreshing) {
            self.refreshControl.endRefreshing()
        }
        
        ArticlesManager.getMostPopularArticles { (resultList, error) in
            guard let responseList = resultList else {
                return
            }
            self.articleList = responseList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureListView() {
        self.navigationItem.title = "NY Times Most Popular"
        //Register Cell
        self.tableView.register(UINib(nibName: "ArticleRowViewCell", bundle: nil), forCellReuseIdentifier: "ArticleRowViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 1000
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshViewController), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destinationVC = segue.destination as? ArticleDetailViewController {
                destinationVC.representedArticleModel = self.articleList?[(sender as! IndexPath).row]
            }
        }
    }
}

extension ViewController : UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleList!.count
    }
    
    //Cell??
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleRowViewCell", for: indexPath) as! ArticleRowViewCell
        cell.artical = self.articleList?[indexPath.row]
        cell.updateRowModal()
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
}

