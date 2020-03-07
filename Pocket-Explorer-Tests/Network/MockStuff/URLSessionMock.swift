//
//  URLSessionMock.swift
//  Choco-ExampleTests
//
//  Created by Roxana Bucura on 25.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation
@testable import Pocket_Explorer

class URLSessionMock: URLSession {
    
    // Properties that enable us to set exactly what data or error
    // we want our mocked URLSession to return for any request.
    var data: Data?
    var error: Error?
    var response: URLResponse?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTaskMock {
            completionHandler(self.data, self.response, self.error)
        }
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTaskMock {
            completionHandler(self.data, self.response, self.error)
        }
    }
}
