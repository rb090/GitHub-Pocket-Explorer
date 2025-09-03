//
//  NetworkRequestUtils.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 26.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

class NetworkRequestUtils {
    // request object without body data
    func makeRequestObjectFor(url: URL, httpMethod: HTTPMethod) -> URLRequest? {
        // use standard cache policy and time interval
        var backendRequest = URLRequest(url: url)
        backendRequest.httpMethod = httpMethod.rawValue                
        return backendRequest
    }
    
    func errorCreatingRequestObject() -> Error {
        let errorString = "Cannot create request object here"
        let error = NSError(domain: ErrorDomainDescription.networkRequestDomain.rawValue, code: ErrorDomainCode.errorWhenCreateRequestObject.rawValue, userInfo: [NSLocalizedDescriptionKey: errorString])
        return error
    }
    
    func errorCodeFrom(error: Error) -> Int {
        let errorAsNsError = error as NSError
        return errorAsNsError.code
    }
}
