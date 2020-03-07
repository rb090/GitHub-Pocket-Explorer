//
//  CommonPrimaryButton.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 11.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import SwiftUI

struct CommonPrimaryButtonStyle: View {
    var imageName: String?
    var buttonText: Text
    var leadingTrailingSpace: CGFloat
    var height: CGFloat
    
    var body: some View {
        HStack {
            if imageName != nil {
                Image(systemName: imageName!).foregroundColor(.white)
            }
            buttonText.foregroundColor(.white)
        }.frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: height, idealHeight: height, maxHeight: height, alignment: .center)
            .background(Color.purple)
            .cornerRadius(5)
            .padding(.init(top: 0, leading: leadingTrailingSpace, bottom: 0, trailing: leadingTrailingSpace))
    }
}
