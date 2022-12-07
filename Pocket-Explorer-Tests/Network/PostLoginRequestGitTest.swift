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
    
    func test_postLoginCode_failBecauseNoRequestCreationPossible() async {
        let loginAccessToken = await postLoginGit.postLoginCode(authCode: "code", state: "random-state")
        XCTAssertNil(loginAccessToken)
    }
    
    func test_postLoginCode_someErrorHappens() async {
        let errorExpected = NSError(domain: ErrorDomainDescription.networkRequestDomain.rawValue, code: ErrorDomainCode.unexpectedResponseFromAPI.rawValue, userInfo: [NSLocalizedDescriptionKey: "Cannot create request object here"])
        requestManagerMock.isSuccess = false
        requestManagerMock.error = errorExpected
        
        let loginAccessTokenResult = await postLoginGitMock.postLoginCode(authCode: "auth-code", state: "random-state")
        XCTAssertNil(loginAccessTokenResult)
    }
    
    func test_postLoginCode_success() async {
        let expectedResult = requestManagerMock.accessTokenDto()
        
        let loginAccessTokenResult = await postLoginGitMock.postLoginCode(authCode: "auth-code", state: "random-state-string")
        XCTAssertNotNil(loginAccessTokenResult)
        XCTAssertEqual(loginAccessTokenResult?.accessToken, expectedResult.accessToken)
    }
}
