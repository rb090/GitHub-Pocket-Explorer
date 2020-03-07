//
//  String+Localizable.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 24.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

extension String {
    // write an extension to read string from Localizable file
    // better readability (or maybe a little bit more beautiful) instead of the direct usage of 'NSLocalizedString'
    static func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
