//
//  NavigationBarBackButton.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 03.09.25.
//  Copyright © 2019 RB. All rights reserved.
//

import SwiftUI

/// A reusable custom back button for use in navigation bars.
///
/// This view displays a left-pointing arrow icon in purple.
/// When tapped, it calls the `dismiss` environment action to pop the current view off the navigation stack or dismiss a modal.
///
/// Use this in a `.toolbar` with `placement: .topBarLeading` to override the default back button style for some nicer UI.
struct NavigationBarBackButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "arrow.left")
                .foregroundColor(DesignSystem.AppColors.primary)
        }
    }
}

#Preview("CustomBackButton") {
    NavigationStack {
        VStack(spacing: 20) {
            Text("Detail Screen").font(.title2)
        }
        .navigationTitle("Detail")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBarBackButton()
            }
        }
    }
}
