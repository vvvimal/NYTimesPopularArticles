//
//  BaseTests.swift
//  NYTimesPopularArticlesTests
//
//  Created by Venugopalan, Vimal on 12/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import XCTest
@testable import NYTimesPopularArticles

class BaseTests: XCTestCase {
    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    /// Create list view controller
    func createListViewController() -> ArticlesListViewController {
        guard let vc = mainStoryboard.instantiateViewController(withIdentifier: "ArticlesListViewController") as? ArticlesListViewController else {
            fatalError("Unable to create ArticlesListViewController from storyboard.")
        }
        return vc
    }
    
    /// Create detail view controller
    func createDetailViewController() -> ArticlesDetailViewController {
        guard let vc = mainStoryboard.instantiateViewController(withIdentifier: "ArticlesDetailViewController") as? ArticlesDetailViewController else {
            fatalError("Unable to create ArticlesDetailViewController from storyboard.")
        }
        return vc
    }
}
