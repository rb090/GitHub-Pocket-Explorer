//
//  NetworkRequestManager.swift
//
//  Created by Roxana Bucura on 01.04.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

protocol NetworkRequestManagerProtocol {
    func makeNetworkRequest<T: Decodable>(urlRequestObject: URLRequest) async -> Result<T, Error>
}

// general class with protocol and error handling used for network communication
class NetworkRequestManager: NetworkRequestManagerProtocol {
    
    private let session: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        session = urlSession
    }
    
    func makeNetworkRequest<T: Decodable>(urlRequestObject: URLRequest) async -> Result<T, Error> {
        do {
            let (data, response) = try await session.data(for: urlRequestObject, delegate: nil)
            
            let httpStatus = response as? HTTPURLResponse
            
            // statusCode 200 -> OK, request was successful
            // statusCode 201 -> Created, request was successful, the requested resource was created by server
            // statusCode 204 -> No Content, request ws successful, response does not contain data
            guard httpStatus?.statusCode == 200 || httpStatus?.statusCode == 201 || httpStatus?.statusCode == 204 else {
                let errorString = "unsuccessful request, http code: \(String(describing: httpStatus?.statusCode))"
                let error = NSError(domain: ErrorDomainDescription.networkResponseDomain.rawValue, code: httpStatus?.statusCode ?? ErrorDomainCode.unexpectedResponseFromAPI.rawValue, userInfo: [NSLocalizedDescriptionKey: errorString])
                return .failure(error)
            }
            
            // debugging
            self.logRateLimiting(for: response)
            
            do {
                let decoder = JSONDecoder()
                let dataFromBackend = try decoder.decode(T.self, from: data)
                return .success(dataFromBackend)
            } catch let parsingError {
                let error = NSError(domain: ErrorDomainDescription.networkResponseDomain.rawValue, code: ErrorDomainCode.parseError.rawValue, userInfo: [NSLocalizedDescriptionKey: parsingError.localizedDescription])
                return .failure(error)
            }
            
        } catch {
            return .failure(error)
        }
    }
    
    private func logRateLimiting(for response: URLResponse?) {
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response here: \(String(describing: response))")
            return
        }
        
        let missingHeader = "Missing header"
        let rateLimit = httpResponse.allHeaderFields["X-RateLimit-Limit"] as? String ?? missingHeader
        let rateLimitRemaining = httpResponse.allHeaderFields["X-RateLimit-Remaining"] as? String ?? missingHeader
        let rateLimitReset = httpResponse.allHeaderFields["X-RateLimit-Reset"] as? String ?? missingHeader
        
        print("X-RateLimit-Limit: \(rateLimit)")
        print("X-RateLimit-Remaining: \(rateLimitRemaining)")
        print("X-RateLimit-Reset: \(rateLimitReset)")
    }
}

