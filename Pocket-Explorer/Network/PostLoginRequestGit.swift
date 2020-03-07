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
    
    func postLoginCode(authCode: String, state: String, completion: @escaping (LoginAccessTokenDTO?) -> Void) {
        let gitLoginUrl = urlService.accessTokenUrl(authCode: authCode, state: state)
        
        guard var requestObject = networkRequestUtils.makeRequestObjectFor(url: gitLoginUrl, httpMethod: .post) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        requestObject.addValue("application/json", forHTTPHeaderField: "Accept")
        
        networkRequestHelper.makeNetworkRequest(urlRequestObject: requestObject) { (result: Result<LoginAccessTokenDTO, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let authObject):
                    completion(authObject)
                case .failure(let error):
                    print("error: \(error)")
                    completion(nil)
                }
            }
        }
    }
}
