//
//  NetworkTests.swift
//  NYTimesPopularArticlesTests
//
//  Created by Venugopalan, Vimal on 12/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import XCTest
@testable import NYTimesPopularArticles

struct RequestFailedRequest: BaseRequest {
    var params: [String : Any]? = [:]
    
    var httpMethod: HTTPMethod = .get
    
    var httpHeader: [String : String] = [:]
    
    
    var urlString: String {
        return "https://www.github.com/users?since=0"
    }
}

struct RequestInvalidTokenRequest: BaseRequest {
    var params: [String : Any]? = [:]
    
    var httpMethod: HTTPMethod = .get
    
    var httpHeader: [String : String] = [:]
    
    
    var urlString: String {
        return "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=sample"
    }
}

class NetworkTests: XCTestCase {

    let articleListGetManager = ArticlesListGetManager()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /// Testing Article list API with an invalid url for failed response
    func testArticleListResponseRequestFailed() {
        let expected = expectation(description: "Check request failed response")
        articleListGetManager.getArticlesList(from: RequestFailedRequest(), completion: {
            result in
            switch result {
            case .success( _):
                XCTFail()
            case .failure(let error):
                expected.fulfill()
                XCTAssertEqual(error, APIError.requestFailed)
                XCTAssertEqual(error.message, "Request Failed")
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /// Testing Article list API with an invalid token
    func testArticleListResponseInvalidTokenFailed() {
        let expected = expectation(description: "Check request failed response")
        articleListGetManager.getArticlesList(from: RequestInvalidTokenRequest(), completion: {
            result in
            switch result {
            case .success( _):
                XCTFail()
            case .failure(let error):
                expected.fulfill()
                XCTAssertEqual(error, APIError.requestFailed)
                XCTAssertEqual(error.message, "Request Failed")
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /// Testing Article list API with an valid url for successful response
    func testArticleListSuccessfulResponse() {
        let expected = expectation(description: "Check response is successful")
        articleListGetManager.getArticlesList(from: ArticlesListGetRequest() , completion: {
            result in
            switch result {
            case .success(let articleArray):
                if articleArray != nil{
                    expected.fulfill()
                }
            case .failure( _):
                XCTFail()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
