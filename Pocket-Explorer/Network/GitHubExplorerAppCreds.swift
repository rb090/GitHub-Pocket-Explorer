//
//  GitHubExplorerAppCreds.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 09.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation

struct GitHubExplorerAppCreds {
    static let redirectUri = "gitbrowserapp://"
    static let scope = "public_repo,read:user"
    static let tokenUrl = "https://github.com/login/oauth/access_token"
    static let persistedLoginObject = "LoginAccessTokenDTO"
    
    // 💡 Load secreta configured in separate `Secrets.xcconfig` and referenced in `Info.plist` file
    // Ensure that `Secrets.xcconfig` linked correctly to the Build Configurations of the project.
    static var clientIdGitExplorerApp: String {
        Bundle.main.object(forInfoDictionaryKey: "GH_CLIENT_ID") as? String ?? "NONE"
    }
    static var clientSecretGitExplorerApp: String {
        Bundle.main.object(forInfoDictionaryKey: "GH_CLIENT_SECRET") as? String ?? "NONE"
    }
}
