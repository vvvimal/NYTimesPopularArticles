//
//  ArticlesDetailViewController.swift
//  NYTimesPopularArticles
//
//  Created by Venugopalan, Vimal on 11/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class ArticlesDetailViewController: UIViewController {

    let viewModel = ArticlesDetailViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /// Setup article detail
    /// - Parameter data: article model
    func setupArticle(data:ArticleDataModel){
        viewModel.articleDetail = data
    }
}
