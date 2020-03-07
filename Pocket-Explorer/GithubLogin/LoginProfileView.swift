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
    @ObservedObject var viewModel: LoginProfileViewModel
    
    var body: some View {
        VStack {
            if viewModel.userObject == nil {
                LoginView()
            } else {
                ProfileView(userObject: viewModel.userObject!)
            }            
        }.navigationBarTitle("title_github_access", displayMode: .inline).onAppear {
            self.viewModel.loadUserFromGitHub()
        }
    }
}
