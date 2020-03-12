//
//  ArticlesListViewController.swift
//  NYTimesPopularArticles
//
//  Created by Venugopalan, Vimal on 11/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class ArticlesListViewController: UITableViewController {
    
    var alert : UIAlertController?

    let viewModel = ArticlesListViewModel()

    var detailViewController: ArticlesDetailViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
        self.setupTableView()
        self.getArticleListData()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    /// Set up UI elements
    func setupView(){
        self.title = "Popular Articles"
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ArticlesDetailViewController
        }
    }
    
    /// Setup Table View properties
    func setupTableView(){
        
        self.tableView.accessibilityLabel = "ArticlesListTableView"
        self.tableView.isAccessibilityElement = true
        self.tableView.tableFooterView = UIView()
        self.tableView.register(ArticleListViewCell.self, forCellReuseIdentifier: AppReuseIdentifierStrings.kArticlesListViewCellReuseIdentifier )

        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
    }
    
    /// Get Article list data from API
    func getArticleListData(){
        self.activityStartAnimating()
        viewModel.getArticlesList(completion: {[weak self] result in
            switch result {
            case .success(_):
                self?.reloadTableView()
            case .failure(let error):
                self?.setError(error: error)
            }
        })
    }
    
    //MARK: Actions
       
    /// Refresh Control Action
    ///
    /// - Parameter sender: UIRefreshControl object
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        self.getArticleListData()
    }
    
    /// Reload data after successful API request
    func reloadTableView() {
        DispatchQueue.main.async() { () -> Void in
            self.activityStopAnimating()
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
        
    }
    
    /// Error received from API request
    ///
    /// - Parameter error: APIError
    func setError(error:APIError){
        DispatchQueue.main.async() { () -> Void in
            self.activityStopAnimating()
            self.alert = self.showAlert(withTitle: "Error", message: error.message)
        }
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegueIdentifierStrings.kArticlesDetailViewControllerSegue, let articleModel = sender as? ArticleDataModel {
            let controller = (segue.destination as! UINavigationController).topViewController as! ArticlesDetailViewController
            controller.setupArticle(data: articleModel)
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    // MARK: - Table View

}

extension ArticlesListViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.numberOfSections
    }
    
    /// Tableview datasource for number of rows
    ///
    /// - Parameters:
    ///   - tableView: UITableView Object
    ///   - section: Section of the tableview
    /// - Returns: Integer representing the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    /// Tableview datasource method for getting cell at indexpath
    ///
    /// - Parameters:
    ///   - tableView: UITableView object
    ///   - indexPath: indexPath of the cell
    /// - Returns: UITableViewCell object
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppReuseIdentifierStrings.kArticlesListViewCellReuseIdentifier, for: indexPath) as? ArticleListViewCell else{fatalError("Unable to dequeue cell")}
        
        
        // Configure the cell...
        
        if let article = viewModel.articleAt(index: indexPath){
            cell.article = article
        }
        cell.isAccessibilityElement = true
        
        return cell
    }
    
    /// TableView Delegate method for height of the cell
    ///
    /// - Parameters:
    ///   - tableView: UITableView object
    ///   - indexPath: indexPath of the cell
    /// - Returns: Automatic height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    /// Estimated height for tableview row cell
    ///
    /// - Parameters:
    ///   - tableView: UITableView object
    ///   - indexPath: indexPath of the cell
    /// - Returns: CGFloat value representing the estimated height of the cell
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    /// Tableview did select cell action
    ///
    /// - Parameters:
    ///   - tableView: UITableView object
    ///   - indexPath: indexPath of the cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.articleAt(index: indexPath)
        performSegue(withIdentifier: AppSegueIdentifierStrings.kArticlesDetailViewControllerSegue, sender: article)
    }
    
    
}
