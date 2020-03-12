//
//  ArticlesDetailViewModel.swift
//  NYTimesPopularArticles
//
//  Created by Venugopalan, Vimal on 12/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import UIKit
import WebKit

class ArticlesDetailViewModel: NSObject {
    
    var articleDetail : ArticleDataModel? = nil
    
    /// Clean cache for removing webview cache, as it was asking for signup after ever webview load
    func cleanCache() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("[WebCacheCleaner] All cookies deleted")
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("[WebCacheCleaner] Record \(record) deleted")
            }
        }
    }
    
    /// Webview request from articleDetail
    func webViewURLRequest() -> URLRequest?{
        if let urlString = articleDetail?.url, let url = URL.init(string: urlString) {
            return URLRequest.init(url: url)
        }
        return nil
    }
    
    /// Article title
    func articleTitle() -> String{
        articleDetail?.title ?? "Detail"
    }
}
