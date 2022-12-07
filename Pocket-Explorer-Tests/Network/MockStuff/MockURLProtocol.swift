//
//  MockURLProtocol.swift
//  Pocket-ExplorerTests
//
//  Created by Roxana Bucura on 07.12.22.
//  Copyright © 2022 RB. All rights reserved.
//

import Foundation

// Used implementation from https://gist.github.com/soujohnreis/7c86965efbbb2297d4db3f84027327c1
// So credits goes to soujohnreis - thanks a lot for sharing this piece of code 🙌
class MockURLProtocol: URLProtocol {
    /// Dictionary maps URLs to tuples of error, data, and response
    static var mockURLs = [URL?: (error: Error?, data: Data?, response: HTTPURLResponse?)]()
    
    override class func canInit(with request: URLRequest) -> Bool {
        // Handle all types of requests
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        // Required to be implemented here. Just return what is passed
        return request
    }
    
    override func startLoading() {
        if let url = request.url, let (error, data, response) = MockURLProtocol.mockURLs[url] {
            // We have a mock response specified so return it.
            if let responseStrong = response {
                client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
            }
            
            // We have mocked data specified so return it.
            if let dataStrong = data {
                client?.urlProtocol(self, didLoad: dataStrong)
            }
            
            // We have a mocked error so return it.
            if let errorStrong = error {
                client?.urlProtocol(self, didFailWithError: errorStrong)
            }
        }
        
        // Send the signal that we are done returning our mock response
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        // Required to be implemented. Do nothing here.
    }
}
