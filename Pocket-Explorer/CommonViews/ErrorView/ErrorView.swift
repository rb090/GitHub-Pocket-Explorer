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
            .frame(maxWidth: .infinity, minHeight: 45, alignment: .leading)
            .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 5))
            .foregroundColor(Color.white)
            .background(Color.red)
            .animation(.easeIn, value: errorText)
    }
}

#Preview("Animated ErrorView", traits: .sizeThatFitsLayout) {
    struct ErrorViewPreviewContainer: View {
        @State private var errorText = "Initial error"
        
        var body: some View {
            ErrorView(errorText: errorText).onAppear {
                // Toggle the error text every 2 seconds
                Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                    errorText = (errorText == "Initial error") ? "Something went wrong!" : "Initial error"
                }
            }
            .padding()
        }
    }
    
    return ErrorViewPreviewContainer()
}

#Preview("ErrorView long text", traits: .sizeThatFitsLayout) {
    ErrorView(errorText: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
}
