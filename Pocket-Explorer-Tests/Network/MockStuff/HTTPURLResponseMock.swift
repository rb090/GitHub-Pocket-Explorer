//
//  HTTPURLResponseMock.swift
//  Choco-ExampleTests
//
//  Created by Roxana Bucura on 25.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation
@testable import Pocket_Explorer

class HTTPURLResponseMock: HTTPURLResponse {
    init?(url: URL, statusCode: Int) {
        super.init(url: url, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: [:])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented yet")
    }
}
