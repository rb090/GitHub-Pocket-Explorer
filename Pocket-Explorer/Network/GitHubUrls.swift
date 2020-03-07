//
//  GitHubUrls.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 23.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

class GitHubUrls {
        
    func loadReposUrl(for query: String?, page: Int) -> String? {
        guard let queryString = query else {
            return "https://api.github.com/search/repositories?q=language:swift+sort:stars&page=\(page)"
        }
        
        guard let urlQuery = queryString.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            print("error when creating query string")
            return nil
        }
        
        return "https://api.github.com/search/repositories?q=\(urlQuery)+sort:stars&page=\(page)"
    }
    
    func loginUrl(randomString: String = UUID().uuidString) -> URL {
        let loginUrl = "https://github.com/login/oauth/authorize?client_id=" + GitHubExplorerAppCreds.clientIdGitExplorerApp + "&scope=" + GitHubExplorerAppCreds.scope + "&redirect_uri=" + GitHubExplorerAppCreds.redirectUri + "&state=" + randomString
        return URL(string: loginUrl)!
    }
    
    func accessTokenUrl(authCode: String, state: String) -> URL {
        return URL(string: "https://github.com/login/oauth/access_token?client_id=\(GitHubExplorerAppCreds.clientIdGitExplorerApp)&client_secret=\(GitHubExplorerAppCreds.clientSecretGitExplorerApp)&code=\(authCode)&redirect_uri=\(GitHubExplorerAppCreds.redirectUri)&state=\(state)")!
    }
    
    func reviewAccessUrl() -> URL {
        return URL(string: "https://github.com/settings/connections/applications/\(GitHubExplorerAppCreds.clientIdGitExplorerApp)")!
    }
    
    func getUserUrl() -> URL {
        return URL(string: "https://api.github.com/user")!
    }
}
