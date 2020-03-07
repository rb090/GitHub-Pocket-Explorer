//
//  MockRequestCodable.swift
//  Choco-ExampleTests
//
//  Created by Roxana Bucura on 25.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation
@testable import Pocket_Explorer

struct MockRequestCodable: Codable, Equatable {
    let obj1: String
    let obj2: String
}
