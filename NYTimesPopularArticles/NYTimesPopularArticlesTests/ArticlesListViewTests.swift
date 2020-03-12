//
//  ArticlesListViewTests.swift
//  NYTimesPopularArticlesTests
//
//  Created by Venugopalan, Vimal on 12/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import XCTest
@testable import NYTimesPopularArticles

class ArticlesListViewTests: BaseTests {
    
    var vc: ArticlesListViewController!
    
    var articles : [ArticleDataModel] {
        return[
            ArticleDataModel.init(uri: "nyt://article/49c74e11-ffcb-5ea7-97be-3a0381697a1d", url: "https://www.nytimes.com/2020/03/08/world/coronavirus-news.html", id: 100000007022319, asset_id: 100000007022319, source: "New York Times", published_date: "2020-03-08", updated: "2020-03-11 08:13:37", section: "World", subsection: nil, nytdsection: "world", adx_keywords: "Coronavirus (2019-nCoV);United States Politics and Government;Economic Conditions and Trends;China;Italy;Europe", column: nil, byline: nil, type: "Article", title: "In U.S., Cases of Coronavirus Cross 500, and Deaths Rise to 22", abstract: "A top U.S. health official says regional lockdowns are possible and warns the most vulnerable against travel as a 19th person dies in Washington State.", des_facet: ["Coronavirus (2019-nCoV)", "United States Politics and Government", "Economic Conditions and Trends"], org_facet: [], per_facet: [], geo_facet: ["China", "Italy", "Europe"], media: [MediaDataModel.init(type: "image", subtype: "photo", caption: "The Grand Princess cruise ship off the coast of San Francisco on Sunday. Twenty-one people aboard have tested positive for the coronavirus.", copyright: "Jim Wilson/The New York Times", approved_for_syndication: 1, media_metadata: [MediaMetaDataModel.init(url: "https://static01.nyt.com/images/2020/03/08/us/politics/08virus-briefing-cruise-promo/08virus-briefing-cruise-promo-thumbStandard-v3.jpg", format: "Standard Thumbnail", height: 75, width: 75)])], eta_id: 0),
            ArticleDataModel.init(uri: "nyt://article/58eaf9bd-c29e-5fd2-b00e-54243827d5ba", url: "https://www.nytimes.com/2020/03/05/health/coronavirus-deaths-rates.html", id: 100000007015843, asset_id: 100000007015843, source: "New York Times", published_date: "2020-03-05", updated: "2020-03-11 07:31:37", section: "Health", subsection: nil, nytdsection: "health", adx_keywords: "Epidemics;Mathematics;Coronavirus (2019-nCoV);Influenza;Deaths (Fatalities);Ebola Virus;Hygiene and Cleanliness;your-feed-healthcare;World Health Organization;China;London (England);United States", column: nil, byline: "By James Gorman", type: "Article", title: "The Coronavirus, by the Numbers", abstract: "A mathematician who studies the spread of disease explains some of the figures that keep popping up in coronavirus news.", des_facet: ["Epidemics", "Mathematics", "Coronavirus (2019-nCoV)", "Influenza"], org_facet: ["World Health Organization"], per_facet: [], geo_facet: ["China", "London (England)", "United States"], media: [MediaDataModel.init(type: "image", subtype: "photo", caption: nil, copyright: "Tom Jamieson for The New York Times", approved_for_syndication: 1, media_metadata: [MediaMetaDataModel.init(url: "https://static01.nyt.com/images/2020/03/04/science/04VIRUS-NUMBERS2/04VIRUS-NUMBERS2-thumbStandard.jpg", format: "Standard Thumbnail", height: 75, width: 75)])], eta_id: 0)]
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = createListViewController()
        vc.viewModel.articlesListArray = articles
        vc.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vc = nil
    }
    
    /// Test load view of list view
    func testLoadView() {
        XCTAssertNotNil(vc)
        XCTAssertEqual(vc.title, "NY Times Most Popular", "Invalid title")
        XCTAssertNotNil(vc.tableView)
    }
    
    /// Test number of sections
    func testNumberOfSections() {
        XCTAssertEqual(vc.numberOfSections(in: vc.tableView), vc.viewModel.numberOfSections)
    }
    
    /// Test number of rows
    func testNumberOfRows() {
        for section in 0..<vc.numberOfSections(in: vc.tableView) {
            XCTAssertEqual(vc.tableView(vc.tableView, numberOfRowsInSection: section), vc.viewModel.numberOfRows(inSection: section))
        }
    }
    
    /// Test configure note cell
    func testConfigureUserCell() {
        for article in articles {
            let cell = ArticleListViewCell(style: .default, reuseIdentifier: AppReuseIdentifierStrings.kArticlesListViewCellReuseIdentifier)
            cell.article = article
            XCTAssertEqual(cell.titleLabel.text, article.title)
            XCTAssertNotNil(cell.thumbnailImageView.image)
        }
    }
    
    /// Test cell for row at indexpath
    func testCellForRowAtIndexPath() {
        for section in 0..<vc.numberOfSections(in: vc.tableView) {
            for row in 0..<vc.tableView(vc.tableView, numberOfRowsInSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                guard let cell = vc.tableView(vc.tableView, cellForRowAt: indexPath) as? ArticleListViewCell else {
                    return XCTFail("Incorrect cell type returned.")
                }
                let article = articles[row]
                cell.article = article
                XCTAssertEqual(cell.titleLabel.text, article.title)
                XCTAssertNotNil(cell.thumbnailImageView.image)
            }
        }
    }
    
    /// Test table view didselect cell
    func testSelectCell(){
        
        if vc.tableView.numberOfRows(inSection: 0) > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            vc.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            vc.tableView.delegate?.tableView!(vc.tableView, didSelectRowAt: indexPath)
            
            let waitForTableViewLoadExpectation = XCTestExpectation(description: "Wait for detail.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                waitForTableViewLoadExpectation.fulfill()
            }
            wait(for: [waitForTableViewLoadExpectation], timeout: 2)
        }
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
