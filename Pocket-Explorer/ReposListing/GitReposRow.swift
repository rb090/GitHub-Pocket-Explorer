//
//  GitReposRow.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 23.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import SwiftUI

struct GitReposRow: View {
    let gitRepo: GitRepoDTO
    
    var body: some View {
        
        HStack {
            RemoteImageContainer(imageUrl: gitRepo.owner!.avatarImageUrl)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(gitRepo.repoName)
                    .font(.headline)
                
                Text("\(String.localizedString(forKey: "txt_number_forks")) \(gitRepo.numberOfForks ?? 0)")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                
                Text("\(String.localizedString(forKey: "txt_number_watchers")) \(gitRepo.numberOfWatchers ?? 0)")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct GitRepoCell_Previews : PreviewProvider {
    static var previews: some View {
        let repoOwner = OwnerDTO(avatarImageUrl: URL(string: "https://the.url"), loginName: "login name")
        let license = LicenseDTO(name: "License name", licenseUrl: URL(string: "/license"))
        let gitRepo = GitRepoDTO(id: 1, repoName: "Preview Repo", owner: repoOwner, numberOfForks: 3, numberOfWatchers: 40, repoDescription: "Preview Repo desc", forksUrl: URL(string: "https://the.forks.url"), htmlUrl: URL(string: "https://foo.bar")!, license: license)
        return GitReposRow(gitRepo: gitRepo).previewLayout(.sizeThatFits)
    }
}
