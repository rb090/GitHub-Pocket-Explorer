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
            LoadingView(isLoading: true, activityIndicatorStyle: .medium).padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
            Text(loadingText)
                .font(.headline)
                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                .foregroundColor(Color.blue)
        }
    }
}
