//
//  UIApplication+EndEditing.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 08.12.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
