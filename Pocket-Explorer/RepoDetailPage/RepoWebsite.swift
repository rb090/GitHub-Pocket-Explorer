//
//  RepoWebsite.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 04.01.20.
//  Copyright © 2020 RB. All rights reserved.
//

import SwiftUI

struct RepoWebsite: View {
    var gitRepoWebiste: URL
    var repoName: String
    
    var body: some View {
        VStack {
            WebView(urlForWebview: self.gitRepoWebiste, webviewNavigationDelegate: nil)
        }.navigationBarTitle(Text(repoName), displayMode: .inline)
    }
}
