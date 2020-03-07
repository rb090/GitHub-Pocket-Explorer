//
//  LoginAccessTokenDTO.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 09.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation

struct LoginAccessTokenDTO: Codable {
    let accessToken: String
    let tokenType: String
    let scope: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope = "scope"
    }
}
