//
//  ErrorView.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 01.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    
    var errorText: String
    
    var body: some View {
        VStack {
            Text(self.errorText)
                .font(.headline)
                .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 45, idealHeight: 45, maxHeight: 45, alignment: .leading)
                .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 5))
                .foregroundColor(Color.white)
                .background(Color.red)
                .animation(.easeIn)
        }
    }
}

