//
//  Owner.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 23.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

struct OwnerDTO: Codable {
    let avatarImageUrl: URL?
    let loginName: String
    
    private enum CodingKeys: String, CodingKey {
        case avatarImageUrl = "avatar_url"
        case loginName = "login"
    }
}
