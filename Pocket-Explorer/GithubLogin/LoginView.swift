//
//  LoginView.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 02.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    private let leadingTrailingSpace: CGFloat = 25
    private let gitHubUrls = GitHubUrls()
    
    var body: some View {
        VStack {
            Text("title_github_login")
                .font(.title)
                .padding(.init(top: 20, leading: leadingTrailingSpace, bottom: 0, trailing: leadingTrailingSpace))
            
            Text("txt_login_to_github")
                .font(.subheadline)
                .padding(.init(top: 30, leading: leadingTrailingSpace, bottom: 0, trailing: leadingTrailingSpace))
            
            Button(action: {
                UIApplication.shared.open(self.gitHubUrls.loginUrl())
            }){
                CommonPrimaryButtonStyle(imageName: "person.crop.circle.badge.exclam", buttonText: Text("btn_txt_open_github")).padding(.top)
            }
            
            Spacer()
        }
    }
}
