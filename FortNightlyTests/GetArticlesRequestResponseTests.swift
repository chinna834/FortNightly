//
//  GetArticlesRequestResponseTests.swift
//  FortNightlyTests
//
//  Created by Chinna Addepally on 5/8/21.
//

import XCTest
@testable import FortNightly

class GetArticlesRequestResponseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetArticlesBySourceRequest() {
        let headlinesBySourceRequest = GetNewsArticlesRequest(topHeadlinesBySource: ServerKeys.techcrunchSourceKey)
        
        XCTAssertNotNil(headlinesBySourceRequest)
        XCTAssertEqual(headlinesBySourceRequest.method, HTTPMethod.get.rawValue)
        XCTAssertEqual(headlinesBySourceRequest.url!.absoluteString, "\(ServerKeys.baseNewsAPIURL)\(ServerKeys.versionPath)\(ServerKeys.topHeadlinesPath)\(ServerKeys.sourcesPath)=\(ServerKeys.techcrunchSourceKey)&apiKey=\(ServerKeys.newsAPIKey)")
    }
    
    func testGetArticlesByCategoryRequest() {
        let headlinesByCategoryRequest = GetNewsArticlesRequest(topHeadlinesByCategory: ServerKeys.businessNewsCategoryKey, country: ServerKeys.country_us)
        
        XCTAssertNotNil(headlinesByCategoryRequest)
        XCTAssertEqual(headlinesByCategoryRequest.method, HTTPMethod.get.rawValue)
        XCTAssertEqual(headlinesByCategoryRequest.url!.absoluteString, "\(ServerKeys.baseNewsAPIURL)\(ServerKeys.versionPath)\(ServerKeys.topHeadlinesPath)\(ServerKeys.countryKey)=\(ServerKeys.country_us)&\(ServerKeys.categoryKey)=\(ServerKeys.businessNewsCategoryKey)&apiKey=\(ServerKeys.newsAPIKey)")
    }
    
    func testGetArticlesSuccessResponse() {
        guard let data = UnitTestUtility.jsonObjectForResource("Articles") else {
            XCTFail("Unable to get the json data")
            return
        }
        
        let serverResponse = GetNewsArticlesResponse.parse(data: data, success: true)
        XCTAssertNotNil(serverResponse)
        XCTAssertNotNil(serverResponse!.articlesResponse)
        XCTAssertEqual(serverResponse!.articlesResponse!.articles?.count, 20)
    }
    
    func testGetArticlesFailureResponse() {
        let serverResponse = GetNewsArticlesResponse.parse(data: Data(), success: false)
        XCTAssertNotNil(serverResponse)
        XCTAssertNil(serverResponse!.articlesResponse)
        XCTAssertNotNil(serverResponse!.error)
    }
    
    func testGetArticlesSuccessResponseWithEmptyData() {
        let serverResponse = GetNewsArticlesResponse.parse(data: Data(), success: true)
        XCTAssertNotNil(serverResponse)
        XCTAssertNil(serverResponse!.articlesResponse)
        XCTAssertNotNil(serverResponse!.error)
    }
}
