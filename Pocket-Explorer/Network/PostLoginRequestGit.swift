//
//  PostRequestGit.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 09.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation

class PostLoginRequestGit {
    private var networkRequestHelper: NetworkRequestManagerProtocol
    private let urlService: GitHubUrls
    private var networkRequestUtils: NetworkRequestUtils

    init(networkHelper: NetworkRequestManagerProtocol = NetworkRequestManager(), networkRequestUtilsHelper: NetworkRequestUtils = NetworkRequestUtils(), urlServiceClass: GitHubUrls = GitHubUrls()) {
        networkRequestHelper = networkHelper
        networkRequestUtils = networkRequestUtilsHelper
        urlService = urlServiceClass
    }
    
    func postLoginCode(authCode: String, state: String) async -> LoginAccessTokenDTO? {
        let gitLoginUrl = urlService.accessTokenUrl(authCode: authCode, state: state)
        
        guard var requestObject = networkRequestUtils.makeRequestObjectFor(url: gitLoginUrl, httpMethod: .post) else {
            return nil
        }
        
        requestObject.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let loginResult: Result<LoginAccessTokenDTO, Error> = await networkRequestHelper.makeNetworkRequest(urlRequestObject: requestObject)
        
        if case .success(let authObject) = loginResult {
            return authObject
        } else {
            return nil
        }
    }
}
