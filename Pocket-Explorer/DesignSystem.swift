//
//  DesignSystem.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 03.09.25.
//  Copyright © 2025 RB. All rights reserved.
//

import SwiftUI

enum DesignSystem {
    enum AppColors {
        static let primary: Color = .purple
        static let error: Color = .red
    }
    
    enum Spacing {
        static let xs: CGFloat = 4
        static let s:  CGFloat = 8
        static let m:  CGFloat = 12
        static let l:  CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }

    enum Radius {
        static let s:  CGFloat = 8
        static let m:  CGFloat = 12
        static let l:  CGFloat = 20
    }
    
    enum Size {
        enum Button {
            static let height: CGFloat = 45
            static let corner: CGFloat = 12
        }
    }
}
