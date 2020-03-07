//
//  PostLoginRequestGitTest.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 07.03.20.
//  Copyright © 2020 RB. All rights reserved.
//

import XCTest
@testable import Pocket_Explorer

class PostLoginRequestGitTest: XCTestCase {
    let requestManagerMock = RequestManagerMockPostLogin()
    let requestManager = NetworkRequestManager()
    
    let networkUtilsMock = NetworkRequestUtilsMock()
    let networkUtils = NetworkRequestUtils()
    
    var postLoginGitMock: PostLoginRequestGit!
    var postLoginGit: PostLoginRequestGit!
    
    override func setUp() {
        super.setUp()
        postLoginGitMock = PostLoginRequestGit(networkHelper: requestManagerMock)
        postLoginGit = PostLoginRequestGit(networkHelper: requestManager, networkRequestUtilsHelper: networkUtilsMock)
    }
    
    func test_postLoginCode_failBecauseNoRequestCreationPossible() {
        let expectation = self.expectation(description: "failure POST login request")
        
        postLoginGit.postLoginCode(authCode: "code", state: "random-state") { loginAccessToken in
            XCTAssertNil(loginAccessToken)
            expectation.fulfill()
        }
    
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssert(true)
    }
    
    func test_postLoginCode_someErrorHappens() {
        let expectation = self.expectation(description: "failure POST login request")
        let errorExpected = NSError(domain: ErrorDomainDescription.networkRequestDomain.rawValue, code: ErrorDomainCode.unexpectedResponseFromAPI.rawValue, userInfo: [NSLocalizedDescriptionKey: "Cannot create request object here"])
        requestManagerMock.isSuccess = false
        requestManagerMock.error = errorExpected
        
        postLoginGitMock.postLoginCode(authCode: "auth-code", state: "random-state") { loginAccessTokenResult in
            XCTAssertNil(loginAccessTokenResult)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssert(true)
    }
    
    func test_postLoginCode_success() {
        let expectation = self.expectation(description: "success POST request")
        let expectedResult = requestManagerMock.accessTokenDto()
        
        postLoginGitMock.postLoginCode(authCode: "auth-code", state: "random-state-string") { loginAccessTokenResult in
            XCTAssertNotNil(loginAccessTokenResult)
            XCTAssertEqual(loginAccessTokenResult?.accessToken, expectedResult.accessToken)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssert(true)
    }
}
