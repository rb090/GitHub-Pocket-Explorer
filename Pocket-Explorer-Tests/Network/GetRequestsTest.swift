//
//  GetRequestsTest.swift
//
//  Created by Roxana Bucura on 27.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import XCTest
@testable import Pocket_Explorer

class GetRequestsTest: XCTestCase {
    
    var getRequestMock: GetRequestsGit!
    var getRequest: GetRequestsGit!
    
    let requestManagerMock = RequestManagerMock()
    let requestManager = NetworkRequestManager()
    
    let networkUtilsMock = NetworkRequestUtilsMock()
    let networkUtils = NetworkRequestUtils()
    
    override func setUp() {
        super.setUp()
        getRequestMock = GetRequestsGit(networkHelper: requestManagerMock)
        getRequest = GetRequestsGit(networkHelper: requestManager, networkRequestUtilsHelper: networkUtilsMock)
    }
    
    func test_getJsonData_failBecauseNoRequestCreationPossible() {
        let expectation = self.expectation(description: "failure GET request")
        let errorExpected = networkUtils.errorCreatingRequestObject() as NSError
        
        getRequest.getJsonData(url: URL(string: "/test1")!) { (result: Result<MockResultCodable, Error>) in
            switch result {
            case .success(let successResult):
                XCTAssertNil(successResult)
            case .failure(let errorValue):
                XCTAssertNotNil(errorValue)
                XCTAssertEqual((errorValue as NSError), errorExpected)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssert(true)
    }
    
    func test_getJsonData_success() {
        let expectation = self.expectation(description: "success GET request")
        let successResultDto = MockResultCodable(obj1: "Obj1", obj2: "Obj2")
        
        getRequestMock.getJsonData(url: URL(string: "/test1")!) { (result: Result<MockResultCodable, Error>) in
            switch result {
            case .success(let successResult):
                XCTAssertEqual(successResult, successResultDto)
            case .failure(let errorValue):
                XCTAssertNil(errorValue)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssert(true)
    }
    
    func test_getJsonData_someOtherError() {
        let expectation = self.expectation(description: "failure GET request")
        let errorExpected = NSError(domain: ErrorDomainDescription.networkRequestDomain.rawValue, code: ErrorDomainCode.unexpectedResponseFromAPI.rawValue, userInfo: [NSLocalizedDescriptionKey: "Cannot create request object here"])
        requestManagerMock.isSuccess = false
        requestManagerMock.error = errorExpected
        
        getRequestMock.getJsonData(url: URL(string: "/test1")!) { (result: Result<MockResultCodable, Error>) in
            switch result {
            case .success(let successResult):
                XCTAssertNil(successResult)
            case .failure(let errorValue):
                XCTAssertNotNil(errorValue)
                XCTAssertEqual((errorValue as NSError), errorExpected)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssert(true)
    }
    
    func test_getJsonData_unauthorziedError() {
        let expectation = self.expectation(description: "failure GET request")
        let errorExpected = NSError(domain: ErrorDomainDescription.networkRequestDomain.rawValue, code: 401, userInfo: [NSLocalizedDescriptionKey: "Unauthorized"])
        requestManagerMock.isSuccess = false
        requestManagerMock.error = errorExpected
        
        getRequestMock.getJsonData(url: URL(string: "/test1")!) { (result: Result<MockResultCodable, Error>) in
            switch result {
            case .success(let successResult):
                XCTAssertNil(successResult)
            case .failure(let errorValue):
                // assert that we tried to load 3x
                XCTAssertEqual(self.getRequestMock.numberRetriesLoadRepos, self.getRequestMock.maxNumberRetriesLoadRepos)

                XCTAssertNotNil(errorValue)
                XCTAssertEqual((errorValue as NSError), errorExpected)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssert(true)
    }
}
