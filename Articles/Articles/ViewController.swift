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
    
    // Artical View Modal
    var articleViewModal:PopularArticlesViewModel = PopularArticlesViewModel()
    
    // Selected Day
    var selectedDay:Int = 1;
    
    // Days Label
    @IBOutlet weak var daysLabel:UILabel!
    
    // Activity Indicator
    var activityIndicatorView: UIActivityIndicatorView!
    
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
        
        self.daysLabel.text = "Days \(String(self.selectedDay))"
        self.refreshDays(days: self.selectedDay);
    }
    
    private func refreshDays(days:Int) {
        self.activityIndicatorView.startAnimating()
        self.articleViewModal.getArticles(days: days) { (popularArticles, error) in
            guard let responseList = popularArticles else {
                return
            }
            self.articleList = responseList
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
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
        
        self.activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.tableView.backgroundView = self.activityIndicatorView
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destinationVC = segue.destination as? ArticleDetailViewController {
                destinationVC.index = (sender as! IndexPath).row
                destinationVC.articleViewModal = self.articleViewModal
            }
        }
    }
    
    @IBAction func toggleDays(sender:Any) {
        print("Values is \((sender as! UIStepper).value)")
        switch Int((sender as! UIStepper).value) {
        case 1:
            self.selectedDay = 1
            self.refreshDays(days: 1)
            self.daysLabel.text = "Days \(String(self.selectedDay))"
            break
        case 2:
            self.selectedDay = 7
            self.refreshDays(days: 7)
            self.daysLabel.text = "Days \(String(self.selectedDay))"
            break
        case 3:
            self.selectedDay = 30
            self.refreshDays(days: 30)
            self.daysLabel.text = "Days \(String(self.selectedDay))"
            break
        default:
            break
            // Do nothing
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
        articleViewModal.configureRowView(articleRow: indexPath.row, view: cell)
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
}

