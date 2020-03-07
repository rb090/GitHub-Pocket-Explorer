//
//  NetworkRequestManagerTest.swift
//
//  Created by Roxana Bucura on 27.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import XCTest
@testable import Pocket_Explorer

class NetworkRequestManagerTest: XCTestCase {
    
    var session = URLSessionMock()
    
    var networkManager: NetworkRequestManager!
    
    let networkUtils = NetworkRequestUtils()

    override func setUp() {
        super.setUp()
        networkManager = NetworkRequestManager(urlSession: session)
    }
        
    func test_makeNetworkRequest_success() {
        let url = URL(fileURLWithPath: "/test")
        session.data = "{\"obj1\": \"test\", \"obj2\": \"bla\"}".data(using: .utf8)
        session.error = nil
        session.response = HTTPURLResponseMock(url: url, statusCode: 200)
        
        let expectation = self.expectation(description: "NetworkExpectation")
        
        let networkRequest = networkUtils.makeRequestObjectFor(url: URL(string: "/test")!, httpMethod: .get)
        
        let expectedResultCodable = MockResultCodable(obj1: "test", obj2: "bla")
        
        networkManager.makeNetworkRequest(urlRequestObject: networkRequest!) { (result: Result<MockResultCodable, Error>) in
            switch result {
            case .success(let successResult):
                print("success")
                XCTAssertEqual(successResult, expectedResultCodable)
            case .failure(let errorValue):
                XCTAssertNil(errorValue)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssert(true)
    }

    func test_makeNetworkRequest_failure_ReturnCodeNot200() {
        let url = URL(fileURLWithPath: "/test")
        session.response = HTTPURLResponseMock(url: url, statusCode: 404)
        
        let expectation = self.expectation(description: "NetworkExpectation")
        
        let networkRequest = networkUtils.makeRequestObjectFor(url: URL(string: "/test")!, httpMethod: .get)
                
        networkManager.makeNetworkRequest(urlRequestObject: networkRequest!) { (result: Result<MockResultCodable, Error>) in
            switch result {
            case .success(let successResult):
                print("success")
                XCTAssertNil(successResult)
            case .failure(let errorValue):
                XCTAssertNotNil(errorValue)
                XCTAssertEqual((errorValue as NSError).code, 404)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssert(true)
    }
    
    func test_makeNetworkRequest_failure_dataObjInResponseIsNil() {
        let url = URL(fileURLWithPath: "/test")
        session.data = nil
        session.response = HTTPURLResponseMock(url: url, statusCode: 200)
        
        let expectation = self.expectation(description: "NetworkExpectation")
        
        let networkRequest = networkUtils.makeRequestObjectFor(url: URL(string: "/test")!, httpMethod: .get)
                
        networkManager.makeNetworkRequest(urlRequestObject: networkRequest!) { (result: Result<MockResultCodable, Error>) in
            switch result {
            case .success(let successResult):
                print("success")
                XCTAssertNil(successResult)
            case .failure(let errorValue):
                XCTAssertNotNil(errorValue)
                XCTAssertEqual((errorValue as NSError).code, -2)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssert(true)
    }
    
    func test_makeNetworkRequest_failure_cannotDecodeResultObject() {
        let url = URL(fileURLWithPath: "/test")
        session.data = "{\"obj1\": \"test\" \"obj2\": \"bla\"}".data(using: .utf8)
        session.response = HTTPURLResponseMock(url: url, statusCode: 200)
        
        let expectation = self.expectation(description: "NetworkExpectation")
        
        let networkRequest = networkUtils.makeRequestObjectFor(url: URL(string: "/test")!, httpMethod: .get)
                
        networkManager.makeNetworkRequest(urlRequestObject: networkRequest!) { (result: Result<MockResultCodable, Error>) in
            switch result {
            case .success(let successResult):
                print("success")
                XCTAssertNil(successResult)
            case .failure(let errorValue):
                XCTAssertNotNil(errorValue)
                XCTAssertEqual((errorValue as NSError).code, -3)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssert(true)
    }
}
