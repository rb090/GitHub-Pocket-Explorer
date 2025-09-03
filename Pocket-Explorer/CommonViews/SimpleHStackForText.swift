//
//  SimpleHStack.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 11.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import SwiftUI

struct SimpleHStackForText: View {
    
    var title: String
    var description: String
    
    var body: some View {
        HStack {
            Text("\(title):")
                .bold()
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, DesignSystem.Spacing.xl)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview("SimpleHStackForText", traits: .sizeThatFitsLayout) {
    VStack(alignment: .leading, spacing: 12) {
        SimpleHStackForText(title: "Forks", description: "120")
        SimpleHStackForText(title: "Watchers", description: "89")
        SimpleHStackForText(title: "Stars", description: "240")
    }
    .padding()
}
