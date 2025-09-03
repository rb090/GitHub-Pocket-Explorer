//
//  NetworkRequestUtilsMock.swift
//  Choco-ExampleTests
//
//  Created by Roxana Bucura on 25.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation
@testable import Pocket_Explorer

class NetworkRequestUtilsMock: NetworkRequestUtils {
    override func makeRequestObjectFor(url: URL, httpMethod: HTTPMethod) -> URLRequest? {
        return nil
    }
}
