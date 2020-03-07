//
//  GitHubExplorerAppCreds.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 09.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation

struct GitHubExplorerAppCreds {
    static let clientIdGitExplorerApp = "56b5597e2312e36d6e3e"
    static let clientSecretGitExplorerApp = "ba1682b95fff1038035c2e0da8369c840a48e310"
    static let redirectUri = "gitbrowserapp://"
    static let scope = "public_repo,read:user"
    static let tokenUrl = "https://github.com/login/oauth/access_token"
    static let persistedLoginObject = "LoginAccessTokenDTO"
}
