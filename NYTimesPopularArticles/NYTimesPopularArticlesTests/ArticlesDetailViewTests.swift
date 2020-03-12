//
//  ArticlesDetailViewTests.swift
//  NYTimesPopularArticlesTests
//
//  Created by Venugopalan, Vimal on 12/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import XCTest
@testable import NYTimesPopularArticles

class ArticlesDetailViewTests: BaseTests {

    var vc: ArticlesDetailViewController!

    var article: ArticleDataModel {
        return
            ArticleDataModel.init(uri: "nyt://article/49c74e11-ffcb-5ea7-97be-3a0381697a1d", url: "https://www.nytimes.com/2020/03/08/world/coronavirus-news.html", id: 100000007022319, asset_id: 100000007022319, source: "New York Times", published_date: "2020-03-08", updated: "2020-03-11 08:13:37", section: "World", subsection: nil, nytdsection: "world", adx_keywords: "Coronavirus (2019-nCoV);United States Politics and Government;Economic Conditions and Trends;China;Italy;Europe", column: nil, byline: nil, type: "Article", title: "In U.S., Cases of Coronavirus Cross 500, and Deaths Rise to 22", abstract: "A top U.S. health official says regional lockdowns are possible and warns the most vulnerable against travel as a 19th person dies in Washington State.", des_facet: ["Coronavirus (2019-nCoV)", "United States Politics and Government", "Economic Conditions and Trends"], org_facet: [], per_facet: [], geo_facet: ["China", "Italy", "Europe"], media: [MediaDataModel.init(type: "image", subtype: "photo", caption: "The Grand Princess cruise ship off the coast of San Francisco on Sunday. Twenty-one people aboard have tested positive for the coronavirus.", copyright: "Jim Wilson/The New York Times", approved_for_syndication: 1, media_metadata: [MediaMetaDataModel.init(url: "https://static01.nyt.com/images/2020/03/08/us/politics/08virus-briefing-cruise-promo/08virus-briefing-cruise-promo-thumbStandard-v3.jpg", format: "Standard Thumbnail", height: 75, width: 75)])], eta_id: 0)
        
    }

    var noURLArticle: ArticleDataModel{
        return ArticleDataModel.init(uri: "nyt://article/49c74e11-ffcb-5ea7-97be-3a0381697a1d", url: "", id: 100000007022319, asset_id: 100000007022319, source: "New York Times", published_date: "2020-03-08", updated: "2020-03-11 08:13:37", section: "World", subsection: nil, nytdsection: "world", adx_keywords: "Coronavirus (2019-nCoV);United States Politics and Government;Economic Conditions and Trends;China;Italy;Europe", column: nil, byline: nil, type: "Article", title: "In U.S., Cases of Coronavirus Cross 500, and Deaths Rise to 22", abstract: "A top U.S. health official says regional lockdowns are possible and warns the most vulnerable against travel as a 19th person dies in Washington State.", des_facet: ["Coronavirus (2019-nCoV)", "United States Politics and Government", "Economic Conditions and Trends"], org_facet: [], per_facet: [], geo_facet: ["China", "Italy", "Europe"], media: [MediaDataModel.init(type: "image", subtype: "photo", caption: "The Grand Princess cruise ship off the coast of San Francisco on Sunday. Twenty-one people aboard have tested positive for the coronavirus.", copyright: "Jim Wilson/The New York Times", approved_for_syndication: 1, media_metadata: [MediaMetaDataModel.init(url: "https://static01.nyt.com/images/2020/03/08/us/politics/08virus-briefing-cruise-promo/08virus-briefing-cruise-promo-thumbStandard-v3.jpg", format: "Standard Thumbnail", height: 75, width: 75)])], eta_id: 0)
    }
    
    override func setUp() {
        vc = createDetailViewController()
        
    }
    
    override func tearDown() {
        vc = nil
    }
    
    /// Test load view of Web view
    func testLoadView() {
        vc.setupArticle(data: article)
        vc.loadViewIfNeeded()
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.webView)
    }
    
    /// Test title view
    func testTitleView(){
        vc.setupArticle(data: article)
        vc.loadViewIfNeeded()
        XCTAssertEqual(article.title, vc.title, "Title and image title don't match")
    }
    
    /// Test url present
    func testWebViewLoad(){
        vc.setupArticle(data: article)
        vc.loadViewIfNeeded()
        let loadImageExpectation = XCTestExpectation(description: "Waiting for image load.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            loadImageExpectation.fulfill()
        }
        wait(for: [loadImageExpectation], timeout: 10.0)
        XCTAssertNotNil(vc.webView?.url, "URL is available")
    }
    
    /// Test no url available
    func testWebViewLoadError(){
        vc.setupArticle(data: noURLArticle)
        vc.loadViewIfNeeded()
        let loadImageExpectation = XCTestExpectation(description: "Waiting for webpage to load.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            loadImageExpectation.fulfill()
        }
        wait(for: [loadImageExpectation], timeout: 2)
        XCTAssertNil(vc.webView?.url, "URL is not available")
    }
}
