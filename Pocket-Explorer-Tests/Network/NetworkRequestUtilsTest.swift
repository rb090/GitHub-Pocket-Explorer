//
//  NetworkRequestTest.swift
//
//  Created by Roxana Bucura on 26.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import XCTest
@testable import Pocket_Explorer

class NetworkRequestUtilsTest: XCTestCase {
    
    var networkRequestUtils = NetworkRequestUtils()
    
    func test_makeRequestObject_success() {
        let theUrl = URL(string: "blablablub")
        let requestObject = networkRequestUtils.makeRequestObjectFor(url: theUrl!, httpMethod: HTTPMethod.get)
        XCTAssertNotNil(requestObject)
        XCTAssertEqual(requestObject?.url, theUrl)
        XCTAssertEqual(requestObject?.httpMethod, "GET")
    }
    
    func test_errorCreateRequestObject() {
        let error = networkRequestUtils.errorCreatingRequestObject() as NSError
        XCTAssertEqual(error.localizedDescription, "Cannot create request object here")
        XCTAssertEqual(error.domain, ErrorDomainDescription.networkRequestDomain.rawValue)
        XCTAssertEqual(error.code, ErrorDomainCode.errorWhenCreateRequestObject.rawValue)
    }
    
    func test_errorCodeFromError() {
        let error = NSError(domain: "a domain", code: 400, userInfo: nil)
        let errorCode = networkRequestUtils.errorCodeFrom(error: error)
        XCTAssertEqual(400, errorCode)
    }
}
