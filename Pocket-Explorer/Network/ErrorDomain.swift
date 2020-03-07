//
//  ErrorDomain.swift
//
//  Created by Roxana Bucura on 01.04.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

public enum ErrorDomainDescription: String {
    // if request data has errors (i.e. json not valid)
    case networkRequestDomain = "NetworkRequest"
    // check if network response has an error (i.e. offline or the http status code not 200)
    case networkResponseDomain = "NetworkResponse"
}

public enum ErrorDomainCode: Int {
    case unexpectedResponseFromAPI = -1
    case missingDataResult = -2
    case parseError = -3
    case errorWhenCreateRequestObject = -4
    case encodeError = -5
}
