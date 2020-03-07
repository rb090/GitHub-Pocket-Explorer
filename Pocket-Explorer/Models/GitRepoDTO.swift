//
//  GitRepo.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 23.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

struct GitRepoDTO: Codable {
    var id: Double
    let repoName: String
    
    let owner: OwnerDTO?
    let numberOfForks: Int?
    let numberOfWatchers: Int?
    let repoDescription: String?
    let forksUrl: URL?
    let htmlUrl: URL
    let license: LicenseDTO?
        
    // use CodingKeys to not depend on the naming of the api
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case owner = "owner"
        case repoName = "name"
        case repoDescription = "description"
        case forksUrl = "forks_url"
        case numberOfForks = "forks_count"
        case numberOfWatchers = "watchers_count"
        case htmlUrl = "html_url"
        case license = "license"
    }
}
