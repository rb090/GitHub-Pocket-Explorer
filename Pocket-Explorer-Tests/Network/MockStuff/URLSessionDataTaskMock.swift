//
//  URLSessionDataTaskMock.swift
//  Choco-ExampleTests
//
//  Created by Roxana Bucura on 25.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation
@testable import Pocket_Explorer

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}
