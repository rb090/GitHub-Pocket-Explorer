//
//  DeeplinkHelper.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 10.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation
import Combine

// TODO write tests
class DeeplinkHelper {
    
    private let postLoginHelper: PostLoginRequestGit
    
    init(loginHelper: PostLoginRequestGit = PostLoginRequestGit()) {
        postLoginHelper = loginHelper
    }
    
    func handleGithub(appRedirectUrl: URL?) {
        guard let requestUrl = appRedirectUrl, requestUrl.absoluteString.starts(with: GitHubExplorerAppCreds.redirectUri), let urlComponents = URLComponents(string: requestUrl.absoluteString) else { return }
        
        guard let codeForAuthorization = urlComponents.queryItems?.first(where: { $0.name == "code" })?.value, let stateRandomString = urlComponents.queryItems?.first(where: { $0.name == "state" })?.value else {
            print("missing attributes to proceed login")
            return
        }
        
        print("code from github: \(codeForAuthorization), random state string: \(stateRandomString)")
        
        postLoginHelper.postLoginCode(authCode: codeForAuthorization, state: stateRandomString) { (authObject) in
            guard let authObjectValue = authObject else {
                // maybe handle errors here later if necessary
                return
            }
            // save the auth object locally on the disc here
            UserDefaults.standard.save(authObjectValue, forKey: GitHubExplorerAppCreds.persistedLoginObject)
            
            // notify other classes about the success of entering app from deeplink, so that reload profile event can be triggered
            NotificationCenter.default.post(name: .reloadProfile, object: nil)
        }
    }
}
