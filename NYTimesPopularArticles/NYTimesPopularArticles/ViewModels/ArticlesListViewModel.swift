//
//  ArticlesListViewModel.swift
//  NYTimesPopularArticles
//
//  Created by Venugopalan, Vimal on 11/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class ArticlesListViewModel: NSObject {
    var articlesListArray:[ArticleDataModel] = []
        
    var numberOfSections = 1
    
    private let articlesListGetManager = ArticlesListGetManager()
    
    
    /// Trigger Articles Fetch Request
    func getArticlesList(completion: @escaping (Result<Bool, APIError>) -> Void){
        articlesListGetManager.getArticlesList(from: ArticlesListGetRequest(), completion: {[weak self]
            result in
            switch result {
            case .success(let articlesResponseModel):
                self?.articlesListArray = articlesResponseModel?.results ?? []
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    /// Article at index
    /// - Parameter index: indexpath object
    func articleAt(index:IndexPath) -> ArticleDataModel?{
        index.row < articlesListArray.count ? articlesListArray[index.row] : nil
    }
    
    /// Number of rows for table view
    /// - Parameter inSection: Section of tableview
    func numberOfRows(inSection: Int) -> Int{
        articlesListArray.count
    }
}
