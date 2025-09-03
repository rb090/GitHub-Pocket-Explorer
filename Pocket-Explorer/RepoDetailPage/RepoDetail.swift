//
//  RepoDetail.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 22.12.19.
//  Copyright © 2019 RB. All rights reserved.
//

import SwiftUI

struct RepoDetail: View {
    let webService: GetRequestsGit
        
    var gitRepoForDetailpage: GitRepoDTO
    
    var body: some View {
        VStack {
            RemoteImageContainer(imageUrl: gitRepoForDetailpage.owner?.avatarImageUrl, width: 100, height: 100).padding(.bottom).padding(.top)
            
            Text(gitRepoForDetailpage.repoName)
                .bold()
                .font(.title)
                .padding(.horizontal, DesignSystem.Spacing.xl)
            
            VStack(alignment: .leading) {
                if gitRepoForDetailpage.repoDescription != nil {
                    Text(gitRepoForDetailpage.repoDescription!)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, DesignSystem.Spacing.xxl)
                        .padding(.horizontal, DesignSystem.Spacing.xl)
                }
                
                if gitRepoForDetailpage.license?.name != nil {
                    SimpleHStackForText(title: String.localizedString(forKey: "txt_license"), description: gitRepoForDetailpage.license!.name)
                        .padding(.top, DesignSystem.Spacing.xs)
                }
            }
            
            if gitRepoForDetailpage.numberOfForks ?? 0 > 0 {
                NavigationLink(destination: GitRepoForksList(webService: webService, gitRepo: gitRepoForDetailpage), label: {
                    CommonPrimaryButtonStyle(imageName: nil, buttonText: Text("btn_txt_forks")).padding(.top, DesignSystem.Spacing.l)
                })
            }
            
            NavigationLink(destination: RepoWebsite(gitRepoWebiste: self.gitRepoForDetailpage.htmlUrl, repoName: self.gitRepoForDetailpage.repoName), label: {
                CommonPrimaryButtonStyle(imageName: nil, buttonText: Text("btn_txt_open_github")).padding(.top, DesignSystem.Spacing.l)
            })
            
            Spacer()
        }
        .navigationBarTitle("title_repo_detail", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) { NavigationBarBackButton() }
            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(
                    item: gitRepoForDetailpage.htmlUrl,
                    preview: SharePreview(gitRepoForDetailpage.repoName, icon: Image(systemName: "link"))
                ) {
                    Image(systemName: "square.and.arrow.up").foregroundColor(DesignSystem.AppColors.primary)
                }
            }
        }
    }
}

#Preview("RepoDetail") {
    NavigationStack {
        let repoOwner = OwnerDTO(avatarImageUrl: URL(string: "https://the.url"), loginName: "login name")
        let license = LicenseDTO(name: "License name", licenseUrl: URL(string: "/license"))
        let gitRepo = GitRepoDTO(id: 1, repoName: "Preview Repo", owner: repoOwner, numberOfForks: 3, numberOfWatchers: 40, repoDescription: "Preview Repo desc", forksUrl: URL(string: "https://the.forks.url"), htmlUrl: URL(string: "https://foo.bar")!, license: license)
        RepoDetail(webService: GetRequestsGit(), gitRepoForDetailpage: gitRepo)
    }
}

