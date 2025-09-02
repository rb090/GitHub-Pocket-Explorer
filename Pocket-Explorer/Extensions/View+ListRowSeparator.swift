//
//  View+ListRowSeparator.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 02.09.2025.
//  Copyright © 2019 RB. All rights reserved.
//

import SwiftUI

extension View {

    /// Extends list row separators to span the full width of the screen by overriding the default leading alignment guide.
    ///
    /// The leading offset is intentionally fixed to `-20` in order to remove the system’s default left padding.
    ///
    /// - Returns: A view whose list row separators render across the full width.
    func fullWidthSeparators() -> some View {
        self.alignmentGuide(.listRowSeparatorLeading) { _ in -20 }
    }
}
