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
                
        print("url: \(backendRequest.url?.absoluteString ?? "missing backendRequest.url")")
        return backendRequest
    }

    // make request object with body data (example post/put)
    func makeRequestObjectWithRequestBodyFor<T: Encodable>(url: URL, httpMethod: HTTPMethod, requestObject: T) -> URLRequest? {
        var backendRequest = makeRequestObjectFor(url: url, httpMethod: httpMethod)

        let encoder = JSONEncoder()
        guard let httpBody = try? encoder.encode(requestObject) else { return nil }
        backendRequest?.httpBody = httpBody
        
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
