//
//  PocketExplorerApp.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 03.09.25.
//  Copyright © 2025 RB. All rights reserved.
//

import SwiftUI

@main
struct PocketExplorerApp: App {
    
    var body: some Scene {
        WindowGroup {
            GitReposList(webService: GetRequestsGit())
                .onOpenURL { url in
                // Handles custom URL schemes & universal links arriving while app is foreground/background
                DeeplinkHelper().handleGithub(appRedirectUrl: url)
            }
        }
    }
}
