//
//  ArticlesTests.swift
//  ArticlesTests
//
//  Created by AbdulNaveed Soudagar on 08/11/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import XCTest
@testable import Articles

class ArticlesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testArticles() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let promise = expectation(description: "Status code: 200")
        let viewModel = PopularArticlesViewModel()
        viewModel.getArticles(days: 7) { (articles, error) in
            if let articleList = articles {
                if articleList.count > 0 {
                    promise.fulfill()
                }
                else {
                    XCTFail("Returned Zero Articles")
                }
            }
            else {
                XCTFail("View Model Failed to fetch response List")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
