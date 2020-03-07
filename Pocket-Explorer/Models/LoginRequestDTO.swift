//
//  LoginRequestDTO.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 09.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation

struct LoginRequestDTO: Codable {
    let clientId: String
    let clientSecret: String
    let code: String
    let redirectUri: String
    let state: String
    
    private enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case code = "code"
        case redirectUri = "redirect_uri"
        case state = "state"
    }
}
