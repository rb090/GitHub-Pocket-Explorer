//
//  LicenseDTO.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 31.12.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

struct LicenseDTO: Codable {
    let name: String
    let licenseUrl: URL?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case licenseUrl = "url"
    }
}
