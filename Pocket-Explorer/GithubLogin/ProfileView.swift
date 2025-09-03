//
//  ProfileView.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 11.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    private let gitHubUrls = GitHubUrls()
    var userObject: UserDTO
    
    var body: some View {
        VStack {
            RemoteImageContainer(imageUrl: userObject.avatarUrl, width: 100, height: 100).padding(.bottom).padding(.top)
            
            Text(userObject.name)
                .font(.title)
                .padding(.init(top: 10, leading: DesignSystem.Spacing.l, bottom: 0, trailing: DesignSystem.Spacing.l))
            
            VStack {
                if userObject.location != nil {
                    SimpleHStackForText(title: String(localized: "txt_location"), description: userObject.location!).padding(.top)
                }
                
                if userObject.company != nil {
                    SimpleHStackForText(title: String(localized: "txt_company"), description: userObject.company!).padding(.top)
                }
                
                Button(action: {
                    UIApplication.shared.open(self.gitHubUrls.reviewAccessUrl())
                }){
                    CommonPrimaryButtonStyle(imageName: "person.crop.circle", buttonText: Text("btn_txt_review_app_access")).padding(.top)
                }
            }
            
            Spacer()
        }
    }
}
