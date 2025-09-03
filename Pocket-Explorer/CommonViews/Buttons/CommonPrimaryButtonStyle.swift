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
    
    var body: some View {
        HStack {
            if imageName != nil {
                Image(systemName: imageName!).foregroundColor(.white)
            }
            buttonText.foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, minHeight: DesignSystem.Size.Button.height, maxHeight: DesignSystem.Size.Button.height, alignment: .center)
        .background(DesignSystem.AppColors.primary)
        .cornerRadius(5)
        .padding(.horizontal, DesignSystem.Spacing.xl)
    }
}

#Preview("SendButtonWithImage", traits: .sizeThatFitsLayout) {
    CommonPrimaryButtonStyle(
        imageName: "paperplane.fill",
        buttonText: Text("Send")
    )
}

#Preview("ContinueButtonWithoutImage", traits: .sizeThatFitsLayout) {
    CommonPrimaryButtonStyle(
        imageName: nil,
        buttonText: Text("Continue")
    )
}
