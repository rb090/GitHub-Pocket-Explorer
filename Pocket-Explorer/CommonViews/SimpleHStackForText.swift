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
    var leadingTrailingSpace: CGFloat
    
    var body: some View {
        HStack {
            Text("\(title):")
                .bold()
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.init(top: 0, leading: leadingTrailingSpace, bottom: 0, trailing: 0))
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: leadingTrailingSpace))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SimpleHStackForText_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 12) {
            SimpleHStackForText(title: "Forks", description: "120", leadingTrailingSpace: 16)
            SimpleHStackForText(title: "Watchers", description: "89", leadingTrailingSpace: 16)
            SimpleHStackForText(title: "Stars", description: "240", leadingTrailingSpace: 16)
        }
        .padding()
    }
}
