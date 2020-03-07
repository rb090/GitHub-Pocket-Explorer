//
//  MockStuff.swift
//
//  Created by Roxana Bucura on 26.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation
@testable import Pocket_Explorer

class RequestManagerMock: NetworkRequestManagerProtocol {
    var isSuccess = true
    var error: NSError?

    func makeNetworkRequest<T>(urlRequestObject: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if isSuccess {
            let successResultDto = MockResultCodable(obj1: "Obj1", obj2: "Obj2") as! T
            completion(.success(successResultDto))
        } else {
            if let error = error {
                completion(.failure(error))
            }
        }
    }
}

class RequestManagerMockPostLogin: NetworkRequestManagerProtocol {
    var isSuccess = true
    var error: NSError?

    func makeNetworkRequest<T>(urlRequestObject: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if isSuccess {
            let loginAccessToken = self.accessTokenDto() as! T
            completion(.success(loginAccessToken))
        } else {
            if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func accessTokenDto() -> LoginAccessTokenDTO {
        return LoginAccessTokenDTO(accessToken: "access-token", tokenType: "token-type-bearer", scope: "scope")
    }
}
