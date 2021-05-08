//
//  ArticleModelTests.swift
//  FortNightlyTests
//
//  Created by Chinna Addepally on 5/8/21.
//

import XCTest
@testable import FortNightly

class ArticleModelTests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testArticleModel() {
        guard let data = UnitTestUtility.jsonObjectForResource("Articles") else {
            XCTFail("Unable to get the json data")
            return
        }
        let serverResponse = GetNewsArticlesResponse.parse(data: data, success: true)
        guard let firstArticle = serverResponse?.articlesResponse?.articles?.first else {
            XCTFail("Unable to parse the data")
            return
        }
        
        XCTAssertNotNil(firstArticle.publishedAt) //Checking if the actual date is parsed or not\
        XCTAssertNotNil(firstArticle.title)
    }

}
