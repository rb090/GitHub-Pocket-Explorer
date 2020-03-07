//
//  GitHubUrlsTest.swift
//  Pocket-ExplorerTests
//
//  Created by Roxana Bucura on 27.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import XCTest
@testable import Pocket_Explorer

class GitHubUrlsTest: XCTestCase {
    
    let githubUrls = GitHubUrls()
    
    func test_loadReposUrl_noQueryString() {
        let gitUrl = githubUrls.loadReposUrl(for: nil, page: 1)
        XCTAssertEqual(gitUrl, "https://api.github.com/search/repositories?q=language:swift+sort:stars&page=1")
    }
    
    func test_loadReposUrl_failureReturnNilUrl() {
        let str = String(bytes: [0xD8, 0x00] as [UInt8], encoding: String.Encoding.utf16BigEndian)!
        let gitUrl = githubUrls.loadReposUrl(for: str, page: 1)
        XCTAssertEqual(gitUrl, nil)
    }
    
    func test_loadReposUrl_queryString() {
        let gitUrl = githubUrls.loadReposUrl(for: "java", page: 2)
        XCTAssertEqual(gitUrl, "https://api.github.com/search/repositories?q=java+sort:stars&page=2")
    }
    
    func test_loadReposUrl_queryStringWithWhitespace() {
        let gitUrl = githubUrls.loadReposUrl(for: "    java    plain", page: 2)
        XCTAssertEqual(gitUrl, "https://api.github.com/search/repositories?q=java%20%20%20%20plain+sort:stars&page=2")
    }
    
    func test_loadReposUrl_queryStringWithWhitespaceAndEndAndBeginning() {
        let gitUrl = githubUrls.loadReposUrl(for: "     java    ", page: 2)
        XCTAssertEqual(gitUrl, "https://api.github.com/search/repositories?q=java+sort:stars&page=2")
    }
    
    func test_loginUrl() {
        let randomString = UUID().uuidString
        let loginUrl = githubUrls.loginUrl(randomString: randomString)
        let expectedUrl = "https://github.com/login/oauth/authorize?client_id=" + GitHubExplorerAppCreds.clientIdGitExplorerApp + "&scope=" + GitHubExplorerAppCreds.scope + "&redirect_uri=" + GitHubExplorerAppCreds.redirectUri + "&state=" + randomString
        
        XCTAssertNotNil(loginUrl)
        XCTAssertEqual(loginUrl.absoluteString, expectedUrl)
    }
    
    func test_accessTokenUrl() {
        let accessTokenUrl = githubUrls.accessTokenUrl(authCode: "authCode", state: "state")
        let expectedUrl = "https://github.com/login/oauth/access_token?client_id=\(GitHubExplorerAppCreds.clientIdGitExplorerApp)&client_secret=\(GitHubExplorerAppCreds.clientSecretGitExplorerApp)&code=authCode&redirect_uri=\(GitHubExplorerAppCreds.redirectUri)&state=state"
        XCTAssertNotNil(accessTokenUrl)
        XCTAssertEqual(accessTokenUrl.absoluteString, expectedUrl)
    }
    
    func test_reviewAccessUrl() {
        let reviewAccessUrl = githubUrls.reviewAccessUrl()
        XCTAssertNotNil(reviewAccessUrl)
        XCTAssertEqual(reviewAccessUrl.absoluteString, "https://github.com/settings/connections/applications/\(GitHubExplorerAppCreds.clientIdGitExplorerApp)")
    }
    
    func test_getUserUrl() {
        let getUserUrl = githubUrls.getUserUrl()
        XCTAssertNotNil(getUserUrl)
        XCTAssertEqual(getUserUrl.absoluteString, "https://api.github.com/user")
    }
}
