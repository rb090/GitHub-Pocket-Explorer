//
//  LoadingView.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 18.01.20.
//  Copyright © 2020 RB. All rights reserved.
//

import SwiftUI

struct LoadingView: UIViewRepresentable {

    var isLoading: Bool
    var activityIndicatorStyle: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: .zero)
        indicator.style = activityIndicatorStyle
        indicator.hidesWhenStopped = true
        return indicator
    }

    func updateUIView(_ view: UIActivityIndicatorView, context: Context) {
        if self.isLoading {
            view.startAnimating()
        } else {
            view.stopAnimating()
        }
    }
}

#if DEBUG
struct LoadingView_Previews : PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true, activityIndicatorStyle: .large)
    }
}
#endif
