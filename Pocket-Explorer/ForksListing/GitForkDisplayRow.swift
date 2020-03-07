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
            
            VStack(alignment: .leading, spacing: 5) {
                Text(repoForkInfo.userWhoForks.loginName).font(.headline)
            }
        }
    }
}
