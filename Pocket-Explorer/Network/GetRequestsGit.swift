//
//  GetRequestsGit.swift
//
//  Created by Roxana Bucura on 01.04.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

class GetRequestsGit: ObservableObject {
    
    private var networkRequestHelper: NetworkRequestManagerProtocol
    private var networkRequestUtils: NetworkRequestUtils
    
    var numberRetriesLoadRepos = 0
    let maxNumberRetriesLoadRepos = 3

    init(networkHelper: NetworkRequestManagerProtocol = NetworkRequestManager(), networkRequestUtilsHelper: NetworkRequestUtils = NetworkRequestUtils()) {
        networkRequestHelper = networkHelper
        networkRequestUtils = networkRequestUtilsHelper
    }
    
    func getJsonData<T: Decodable>(url: URL?) async -> Result<T, Error> {
        guard let urlValue = url, var requestObject = networkRequestUtils.makeRequestObjectFor(url: urlValue, httpMethod: .get) else {
            return .failure(self.networkRequestUtils.errorCreatingRequestObject())
        }
        
        if let localPersistedAuthObject: LoginAccessTokenDTO = UserDefaults.standard.getObject(forKey: GitHubExplorerAppCreds.persistedLoginObject) {
            requestObject.addValue("\(localPersistedAuthObject.tokenType) \(localPersistedAuthObject.accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        let requestResult: Result<T, Error> = await networkRequestHelper.makeNetworkRequest(urlRequestObject: requestObject)
        
        switch requestResult {
        case .success(let successResult):
            numberRetriesLoadRepos = 0
            return .success(successResult)
        case .failure(let errorValue):
            if returnErrorWhenFetchRepos(error: errorValue, url: url) {
                return .failure(errorValue)
            } else {
                numberRetriesLoadRepos += 1
                return await getJsonData(url: url)
            }
        }
    }
    
    func returnErrorWhenFetchRepos(error: Error, url: URL?) -> Bool {
        let notAuthorizeError = networkRequestUtils.errorCodeFrom(error: error)
        
        guard numberRetriesLoadRepos < maxNumberRetriesLoadRepos, notAuthorizeError == 401 || notAuthorizeError == 403 else {
            // github throws another error (not that user is unauthorized)
            // or max retries reached
            // this error we handle normally
            return true
        }
        
        // github throws error that user logged out
        // delete persisted credentials
        // caller of function needs to try again to fetch repos without credentials header
        UserDefaults.standard.removeObject(forKey: GitHubExplorerAppCreds.persistedLoginObject)
        return false
    }
}
