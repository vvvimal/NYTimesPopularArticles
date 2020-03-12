//
//  NYTimesPopularArticlesUITests.swift
//  NYTimesPopularArticlesUITests
//
//  Created by Venugopalan, Vimal on 11/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import XCTest

class NYTimesPopularArticlesUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launchEnvironment = ["animations" : "0"]
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Test app flow
    func testAppFlow() {
        let tableView = app.tables["ArticlesListTableView"]
        XCTAssertTrue(tableView.cells.element(boundBy: 0).waitForExistence(timeout: 5))
        tableView.cells.allElementsBoundByIndex.last?.tap()
        
        XCTAssertTrue(app.webViews["ArticlesDetailWebView"].waitForExistence(timeout: 2))
        XCTAssertEqual(app.activityIndicators.count, 1,"Activity indicator present.")
        XCTAssert(app.links["New York Times Logo. Click to visit the homepage"].waitForExistence(timeout: 10))
        
        sleep(5)
        XCTAssertEqual(app.activityIndicators.count, 0,"Activity indicator present.")
//        XCTAssertTrue(detailWebView.element(boundBy: 0).waitForExistence(timeout: 5))
        
    }
    
    /// test pull to refresh functionality
    func testPullToRefresh() {
        let weatherListTableView = app.tables["ArticlesListTableView"]
        XCTAssertTrue(weatherListTableView.exists, "The articles list tableview exists")
        
        customSwipe(refElement: weatherListTableView, startdelxy: CGVector(dx: 0.5, dy: 0.2), enddeltaxy: CGVector(dx: 0.5, dy: 1))
        sleep(5)
    }
    
    /// Custom swipe gesture
    ///
    /// - Parameters:
    ///   - refElement: element on which swipe gesture is to be applied
    ///   - startdelxy: start point
    ///   - enddeltaxy: end point
    func customSwipe(refElement:XCUIElement,startdelxy:CGVector,enddeltaxy: CGVector){
        let swipeStartPoint = refElement.coordinate(withNormalizedOffset: startdelxy)
        let swipeEndPoint = refElement.coordinate(withNormalizedOffset: enddeltaxy)
        swipeStartPoint.press(forDuration: 0.05, thenDragTo: swipeEndPoint)
        
    }
    
    /// test background reload
    func testBackGroundReload() {
        
        sleep(5)
        //press home button
        XCUIDevice.shared.press(.home)
        //relaunch app from background
        app.activate()
        sleep(5)
    }
}
