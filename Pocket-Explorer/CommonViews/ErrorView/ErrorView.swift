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
        Text(self.errorText)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, DesignSystem.Spacing.s)
            .padding(.vertical, DesignSystem.Spacing.s)
            .foregroundColor(Color.white)
            .background(Color.red)
            .animation(.easeIn, value: errorText)
    }
}

#Preview("Animated ErrorView", traits: .sizeThatFitsLayout) {
    struct ErrorViewPreviewContainer: View {
        @State private var errorText: String = "An error with short text."
        
        var body: some View {
            ErrorView(errorText: errorText)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                        errorText = (errorText == "An error with short text.") ? "Another thing went wrong, I am a longer text over multiple lines of code! So, here we go way more text to increase the number of lines." : "An error with short text."
                    }
                }
        }
    }
    
    return ErrorViewPreviewContainer()
}

#Preview("ErrorView long text", traits: .sizeThatFitsLayout) {
    ErrorView(errorText: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
}
