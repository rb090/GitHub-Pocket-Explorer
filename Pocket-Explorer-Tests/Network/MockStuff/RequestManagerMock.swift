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
    
    func makeNetworkRequest<T>(urlRequestObject: URLRequest) async -> Result<T, Error> where T : Decodable {
        if isSuccess {
            let successResultDto = MockResultCodable(obj1: "Obj1", obj2: "Obj2") as! T
            return .success(successResultDto)
        } else {
            return .failure(error!)
        }
    }
}

class RequestManagerMockPostLogin: NetworkRequestManagerProtocol {
    var isSuccess = true
    var error: NSError?
    
    func makeNetworkRequest<T>(urlRequestObject: URLRequest) async -> Result<T, Error> where T : Decodable {
        if isSuccess {
            let loginAccessToken = self.accessTokenDto() as! T
            return .success(loginAccessToken)
        } else {
            return .failure(error!)
        }
    }
    
    func accessTokenDto() -> LoginAccessTokenDTO {
        return LoginAccessTokenDTO(accessToken: "access-token", tokenType: "token-type-bearer", scope: "scope")
    }
}
