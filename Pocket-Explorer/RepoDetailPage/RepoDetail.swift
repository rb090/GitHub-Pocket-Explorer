//
//  RepoDetail.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 22.12.19.
//  Copyright © 2019 RB. All rights reserved.
//

import SwiftUI

struct RepoDetail: View {
    @EnvironmentObject var webService: GetRequestsGit
    
    var gitRepoForDetailpage: GitRepoDTO
    
    private let heightButtons: CGFloat = 45
    private let leadingTrailingSpace: CGFloat = 25
    
    var body: some View {
        VStack {
            RemoteImageContainer(imageUrl: gitRepoForDetailpage.owner?.avatarImageUrl, width: 100, height: 100).padding(.bottom).padding(.top)
            
            Text(gitRepoForDetailpage.repoName)
                .bold()
                .font(.title)
                .padding(.init(top: 0, leading: leadingTrailingSpace, bottom: 0, trailing: leadingTrailingSpace))
            
            VStack(alignment: .leading) {
                if gitRepoForDetailpage.repoDescription != nil {
                    Text(gitRepoForDetailpage.repoDescription!)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.init(top: 20, leading: leadingTrailingSpace, bottom: 0, trailing: leadingTrailingSpace))
                }
                
                if gitRepoForDetailpage.license?.name != nil {
                    SimpleHStackForText(title: String.localizedString(forKey: "txt_license"), description: gitRepoForDetailpage.license!.name, leadingTrailingSpace: leadingTrailingSpace).padding(.top)
                }
            }
            
            if gitRepoForDetailpage.numberOfForks ?? 0 > 0 {
                NavigationLink(destination: GitRepoForksList(viewModelForksList: GitRepoForksListViewModel(getReposHelper: self.webService), gitRepoToFetch: self.gitRepoForDetailpage), label: {
                    CommonPrimaryButtonStyle(imageName: nil, buttonText: Text("btn_txt_forks"), leadingTrailingSpace: leadingTrailingSpace, height: 45).padding(.top)
                })
            }
            
            NavigationLink(destination: RepoWebsite(gitRepoWebiste: self.gitRepoForDetailpage.htmlUrl, repoName: self.gitRepoForDetailpage.repoName), label: {
                CommonPrimaryButtonStyle(imageName: nil, buttonText: Text("btn_txt_open_github"), leadingTrailingSpace: leadingTrailingSpace, height: 45).padding(.top)
            })
            
            Spacer()
        }.navigationBarTitle("title_repo_detail", displayMode: .inline).navigationBarItems(trailing: Button(action: {
            self.share(items: [self.gitRepoForDetailpage.htmlUrl])
        }) {
            Image(systemName:"square.and.arrow.up")
                .font(Font.title.weight(.regular))
                .foregroundColor(Color.purple)
        }
        )
    }
    
    @discardableResult
    func share(items: [Any], excludedActivityTypes: [UIActivity.ActivityType]? = nil) -> Bool {
        guard let source = UIApplication.shared.windows.last?.rootViewController else {
            return false
        }
        let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        vc.excludedActivityTypes = excludedActivityTypes
        
        vc.popoverPresentationController?.sourceView = source.view
        vc.popoverPresentationController?.sourceRect =  CGRect(x: UIScreen.main.bounds.width - 100, y: 70, width: 100, height: 0)

        source.present(vc, animated: true)
        return true
    }
}

#if DEBUG
struct RepoDetail_Previews : PreviewProvider {
    static var previews: some View {
        let repoOwner = OwnerDTO(avatarImageUrl: URL(string: "https://the.url"), loginName: "login name")
        let license = LicenseDTO(name: "License name", licenseUrl: URL(string: "/license"))
        let gitRepo = GitRepoDTO(id: 1, repoName: "Preview Repo", owner: repoOwner, numberOfForks: 3, numberOfWatchers: 40, repoDescription: "Preview Repo desc", forksUrl: URL(string: "https://the.forks.url"), htmlUrl: URL(string: "https://foo.bar")!, license: license)
        return RepoDetail(gitRepoForDetailpage: gitRepo).environmentObject(GetRequestsGit())
    }
}
#endif

