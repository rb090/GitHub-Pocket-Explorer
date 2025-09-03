//
//  RepoWebsite.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 04.01.20.
//  Copyright © 2020 RB. All rights reserved.
//

import SwiftUI
import WebKit

struct RepoWebsite: View {
    var gitRepoWebiste: URL
    var repoName: String
        
    var body: some View {
        WebView(urlForWebview: self.gitRepoWebiste, webviewNavigationDelegate: nil)
            .navigationTitle(repoName)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { NavigationBarBackButton() }
            }
    }
}

#Preview("RepoWebsite") {
    NavigationStack {
        RepoWebsite(gitRepoWebiste: URL(string: "https://github.com/apple/swift-algorithms")!, repoName: "swift-algorithms")
    }
}
