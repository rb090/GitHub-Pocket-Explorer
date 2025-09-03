//
//  LoadingRow.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 26.01.20.
//  Copyright © 2020 RB. All rights reserved.
//

import SwiftUI

struct LoadingRow: View {
    
    var loadingText: String
    
    var body: some View {
        HStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: DesignSystem.AppColors.primary))
                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))

            Text(loadingText)
                .font(.headline)
                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                .foregroundColor(DesignSystem.AppColors.primary)
        }
        .frame(maxWidth: .infinity, minHeight: 45, alignment: .leading)
    }
}

#Preview("LoadingRow", traits: .sizeThatFitsLayout) {
    LoadingRow(loadingText: "Loading...")
}
