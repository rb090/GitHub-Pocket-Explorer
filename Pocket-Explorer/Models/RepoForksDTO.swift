//
//  RepoForksDTO.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 23.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

struct RepoForksDTO: Codable, Identifiable {
    let userWhoForks: OwnerDTO
    let id: Double
    
    private enum CodingKeys: String, CodingKey {
        case userWhoForks = "owner"
        case id = "id"
    }
}
