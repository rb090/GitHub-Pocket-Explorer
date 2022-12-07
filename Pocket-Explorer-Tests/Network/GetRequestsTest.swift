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
    
    func test_getJsonData_failBecauseNoRequestCreationPossible() async {
        let errorExpected = networkUtils.errorCreatingRequestObject() as NSError
        
        let result: Result<MockResultCodable, Error> = await getRequest.getJsonData(url: URL(string: "/test1")!)
        
        switch result {
        case .success(let successResult):
            XCTAssertNil(successResult)
        case .failure(let errorValue):
            XCTAssertNotNil(errorValue)
            XCTAssertEqual((errorValue as NSError), errorExpected)
        }
    }
    
    func test_getJsonData_success() async {
        let successResultDto = MockResultCodable(obj1: "Obj1", obj2: "Obj2")
        
        let result: Result<MockResultCodable, Error> = await getRequestMock.getJsonData(url: URL(string: "/test1")!)
        
        switch result {
        case .success(let successResult):
            XCTAssertEqual(successResult, successResultDto)
        case .failure(let errorValue):
            XCTAssertNil(errorValue)
        }
    }
    
    func test_getJsonData_someOtherError() async {
        let errorExpected = NSError(domain: ErrorDomainDescription.networkRequestDomain.rawValue, code: ErrorDomainCode.unexpectedResponseFromAPI.rawValue, userInfo: [NSLocalizedDescriptionKey: "Cannot create request object here"])
        requestManagerMock.isSuccess = false
        requestManagerMock.error = errorExpected
        
        let result: Result<MockResultCodable, Error> = await getRequestMock.getJsonData(url: URL(string: "/test1")!)
        
        switch result {
        case .success(let successResult):
            XCTAssertNil(successResult)
        case .failure(let errorValue):
            XCTAssertNotNil(errorValue)
            XCTAssertEqual((errorValue as NSError), errorExpected)
        }
    }
    
    func test_getJsonData_unauthorziedError() async {
        let errorExpected = NSError(domain: ErrorDomainDescription.networkRequestDomain.rawValue, code: 401, userInfo: [NSLocalizedDescriptionKey: "Unauthorized"])
        requestManagerMock.isSuccess = false
        requestManagerMock.error = errorExpected
        
        let result: Result<MockResultCodable, Error> = await getRequestMock.getJsonData(url: URL(string: "/test1")!)

        switch result {
        case .success(let successResult):
            XCTAssertNil(successResult)
        case .failure(let errorValue):
            // assert that we tried to load 3x
            XCTAssertEqual(self.getRequestMock.numberRetriesLoadRepos, self.getRequestMock.maxNumberRetriesLoadRepos)

            XCTAssertNotNil(errorValue)
            XCTAssertEqual((errorValue as NSError), errorExpected)
        }
    }
}
