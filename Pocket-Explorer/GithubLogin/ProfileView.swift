//
//  ProfileView.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 11.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    private let leadingTrailingSpace: CGFloat = 20
    private let gitHubUrls = GitHubUrls()
    var userObject: UserDTO
    private let heightButtons: CGFloat = 40
    
    var body: some View {
        VStack {
            RemoteImageContainer(imageUrl: userObject.avatarUrl, width: 100, height: 100).padding(.bottom).padding(.top)
            
            Text(userObject.name)
                .font(.title)
                .padding(.init(top: 10, leading: leadingTrailingSpace, bottom: 0, trailing: leadingTrailingSpace))
            
            VStack {
                if userObject.location != nil {
                    SimpleHStackForText(title: String.localizedString(forKey: "txt_location"), description: userObject.location!, leadingTrailingSpace: leadingTrailingSpace).padding(.top)
                }
                
                if userObject.company != nil {
                    SimpleHStackForText(title: String.localizedString(forKey: "txt_company"), description: userObject.company!, leadingTrailingSpace: leadingTrailingSpace).padding(.top)
                }
                
                Button(action: {
                    UIApplication.shared.open(self.gitHubUrls.reviewAccessUrl())
                }){
                    CommonPrimaryButtonStyle(imageName: "person.crop.circle", buttonText: Text("btn_txt_review_app_access"), leadingTrailingSpace: leadingTrailingSpace, height: 45).padding(.top)
                }
            }
            
            Spacer()
        }
    }
}
