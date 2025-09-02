//
//  GitForkDisplayRow.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 23.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation
import SwiftUI

struct GitForkDisplayRow: View {
    let repoForkInfo: RepoForksDTO
    
    var body: some View {
        HStack {
            RemoteImageContainer(imageUrl: repoForkInfo.userWhoForks.avatarImageUrl)
            
            Text(repoForkInfo.userWhoForks.loginName).font(.headline)
                .padding(8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .edgesIgnoringSafeArea(.all)
    }
}
