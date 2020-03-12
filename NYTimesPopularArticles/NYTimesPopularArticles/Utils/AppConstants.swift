//
//  AppConstants.swift
//  NYTimesPopularArticles
//
//  Created by Venugopalan, Vimal on 11/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import UIKit


/// Netwrok data
struct NetworkData{
    static let kAPIKey = "api-key=4A6nlbC418RmJrsjP5v4hyRSSU9WQiQC"
    static let kBaseURL = "http://api.nytimes.com/"
    static let kMostViewedEndpoint = "svc/mostpopular/v2/mostviewed/all-sections/7.json?"
}

/// API related errors
enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case noInternetError
    
    var message: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .noInternetError: return "No Internet Connection"
        }
    }
}

/// App Reuse Identifiers
struct AppReuseIdentifierStrings {
    static let kArticlesListViewCellReuseIdentifier = "ArticlesListViewCellReuseIdentifier"
}

/// App Segue Identifiers
struct AppSegueIdentifierStrings{
    static let kArticlesDetailViewControllerSegue = "ArticlesDetailViewControllerSegue"
}

/// HTTP Method for request
enum HTTPMethod:String{
    case get = "GET"
    case post = "POST"
}

