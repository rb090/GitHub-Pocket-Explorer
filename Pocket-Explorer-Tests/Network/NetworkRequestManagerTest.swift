//
//  NetworkRequestManagerTest.swift
//
//  Created by Roxana Bucura on 27.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import XCTest
@testable import Pocket_Explorer

class NetworkRequestManagerTest: XCTestCase {
            
    let networkUtils = NetworkRequestUtils()
    private let url = URL(string: "https://foo.bar")!
        
    func test_makeNetworkRequest_success() async {
        let mockedSession = mockSession(url: url, data: Data("{\"obj1\": \"test\", \"obj2\": \"bla\"}".utf8), httpStatusCode: 200)
                
        let networkRequest = networkUtils.makeRequestObjectFor(url: url, httpMethod: .get)
        
        let networkManager = NetworkRequestManager(urlSession: mockedSession)
        
        let expectedResultCodable = MockResultCodable(obj1: "test", obj2: "bla")
        
        let result: Result<MockResultCodable, Error> = await networkManager.makeNetworkRequest(urlRequestObject: networkRequest!)
        
        switch result {
        case .success(let successResult):
            XCTAssertEqual(successResult, expectedResultCodable)
        case .failure(let errorValue):
            XCTAssertNil(errorValue)
        }
    }

    func test_makeNetworkRequest_failure_ReturnCodeNot200() async {
        let mockedSession = mockSession(url: url, data: nil, httpStatusCode: 404)
                        
        let networkRequest = networkUtils.makeRequestObjectFor(url: url, httpMethod: .get)
        
        let networkManager = NetworkRequestManager(urlSession: mockedSession)
        
        let result: Result<MockResultCodable, Error> = await networkManager.makeNetworkRequest(urlRequestObject: networkRequest!)
        
        switch result {
        case .success(let successResult):
            print("success")
            XCTAssertNil(successResult)
        case .failure(let errorValue):
            XCTAssertNotNil(errorValue)
            XCTAssertEqual((errorValue as NSError).code, 404)
        }
    }
    
    func test_makeNetworkRequest_failure_dataObjInResponseIsNil() async {
        let mockedSession = mockSession(url: url, data: nil, httpStatusCode: 200)
                
        let networkRequest = networkUtils.makeRequestObjectFor(url: url, httpMethod: .get)
        
        let networkManager = NetworkRequestManager(urlSession: mockedSession)
        
        let result: Result<MockResultCodable, Error> = await networkManager.makeNetworkRequest(urlRequestObject: networkRequest!)
        
        switch result {
        case .success(let successResult):
            print("success")
            XCTAssertNil(successResult)
        case .failure(let errorValue):
            XCTAssertNotNil(errorValue)
            XCTAssertEqual((errorValue as NSError).code, -3)
        }
    }
    
    func test_makeNetworkRequest_failure_cannotDecodeResultObject() async {
        let mockedSession = mockSession(url: url, data: "{\"obj1\": \"test\" \"obj2\": \"bla\"}".data(using: .utf8), httpStatusCode: 200)
                
        let networkRequest = networkUtils.makeRequestObjectFor(url: url, httpMethod: .get)
        
        let networkManager = NetworkRequestManager(urlSession: mockedSession)
        
        let result: Result<MockResultCodable, Error> = await networkManager.makeNetworkRequest(urlRequestObject: networkRequest!)
        
        switch result {
        case .success(let successResult):
            print("success")
            XCTAssertNil(successResult)
        case .failure(let errorValue):
            XCTAssertNotNil(errorValue)
            XCTAssertEqual((errorValue as NSError).code, -3)
        }
    }
    
    // MARK: - Private helper methods
    
    private func mockSession(url: URL, data: Data?, httpStatusCode: Int) -> URLSession {
        let response = HTTPURLResponse(url: url, statusCode: httpStatusCode, httpVersion: nil, headerFields: nil)
        let error: Error? = nil

        MockURLProtocol.mockURLs = [
            url: (error, data, response),
        ]

        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: sessionConfiguration)
    }
}
