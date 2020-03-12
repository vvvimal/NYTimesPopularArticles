//
//  ArticlesListGetManager.swift
//  NYTimesPopularArticles
//
//  Created by Venugopalan, Vimal on 11/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class ArticlesListGetRequest: BaseRequest {
    var httpMethod: HTTPMethod = .get
    var params : [String : Any]? = nil
    var urlString: String = NetworkData.kBaseURL + NetworkData.kMostViewedEndpoint + NetworkData.kAPIKey
    var httpHeader = [String : String]()
}

class ArticlesListGetManager: NetworkManager {
    var session: URLSession
    
    
    /// Init function with URLSession configuration
    ///
    /// - Parameter configuration: URLSessionConfiguration
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    /// Get Articles Detail List
    ///
    /// - Parameters:
    ///   - request: BaseRequest object to check negative cases, should be ArticlesListGetRequest
    ///   - completion: Result consisting of the ArticlesDataModel Object or APIError
    func getArticlesList(from request: BaseRequest, completion: @escaping (Result<ArticlesListResponseModel?, APIError>) -> Void) {
        if let requestObj = request.request{
            fetch(with: requestObj, decode: { json -> ArticlesListResponseModel? in
                guard let articlesListModelResult = json as? ArticlesListResponseModel else { return  nil }
                return articlesListModelResult
            }, completion: completion)
        }
        else{
            completion(Result.failure(.requestFailed))
        }
    }
}
