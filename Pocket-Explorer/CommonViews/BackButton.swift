//
//  BackButton.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 16.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import SwiftUI

struct BackButton: View {
    
    var backAction: (() -> ())
    
    init(action: @escaping (() -> ())) {
        backAction = action
    }
    
    var body: some View {
        Button(action: {
            self.backAction()
        }) {
            Image(systemName:"chevron.left")
                .font(Font.title.weight(.regular))
                .foregroundColor(Color.purple)
        }
    }
}
