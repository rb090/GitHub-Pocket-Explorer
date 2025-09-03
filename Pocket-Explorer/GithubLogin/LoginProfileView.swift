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
    }
}
