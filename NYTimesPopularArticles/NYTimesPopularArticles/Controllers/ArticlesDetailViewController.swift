//
//  ArticlesDetailViewController.swift
//  NYTimesPopularArticles
//
//  Created by Venugopalan, Vimal on 11/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import UIKit
import WebKit

class ArticlesDetailViewController: UIViewController {

    var alert : UIAlertController?

    @IBOutlet weak var webView:WKWebView?
    
    let viewModel = ArticlesDetailViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUIDetails()
        setupWebview()
    }

    /// Setup article detail
    /// - Parameter data: article model
    func setupArticle(data:ArticleDataModel){
        viewModel.articleDetail = data
    }
    
    func setupUIDetails(){
        self.title = viewModel.articleTitle()
    }
    
    func setupWebview(){
        webView?.accessibilityLabel = "ArticlesDetailWebView"
        webView?.navigationDelegate = self
        self.activityStartAnimating()
        if let request = viewModel.webViewURLRequest(){
            viewModel.cleanCache()
            webView?.load(request)
        }
        else{
            self.activityStopAnimating()
            alert = self.showAlert(withTitle: "Error", message: "No valid request.")
        }
    }
}

extension ArticlesDetailViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        self.activityStopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        self.activityStopAnimating()
        alert = self.showAlert(withTitle: "Error", message: error.localizedDescription)
    }

}
