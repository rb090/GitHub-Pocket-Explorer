//
//  UserDTO.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 11.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation

struct UserDTO: Codable {
    let loginUsername: String
    let avatarUrl: URL
    let githubPageHtml: URL
    let repos_url: URL?
    let name: String
    let company: String?
    let location: String?
    
     private enum CodingKeys: String, CodingKey {
        case loginUsername = "login"
        case avatarUrl = "avatar_url"
        case githubPageHtml = "html_url"
        case repos_url = "repos_url"
        case name = "name"
        case company = "company"
        case location = "location"
    }
}
