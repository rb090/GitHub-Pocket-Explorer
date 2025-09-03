//
//  LoginProfileView.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 11.02.20.
//  Copyright © 2020 RB. All rights reserved.
//


import SwiftUI
import Combine

struct LoginProfileView: View {
    private let webService: GetRequestsGit
    @StateObject var viewModel: LoginProfileViewModel
    
    @Environment(\.scenePhase) private var scenePhase
    
    init(webService: GetRequestsGit) {
        self.webService = webService
        _viewModel = StateObject(wrappedValue: LoginProfileViewModel(webService: webService))
    }
    
    var body: some View {
        VStack {
            if viewModel.userObject == nil {
                LoginView()
            } else {
                ProfileView(userObject: viewModel.userObject!)
            }
        }
        .navigationBarTitle("title_github_access", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) { NavigationBarBackButton() }
        }
        .task {
            self.viewModel.loadUserFromGitHub()
        }
        // Check for the GitHub user also when app became active from background
        // 🚧 GitHub accessToken not invalidated immediately after logout on the profile, takes ca. 1-2 minutes!
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                viewModel.loadUserFromGitHub()
            }
        }
    }
}
