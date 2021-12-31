//
//  GitRepoForksList.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 24.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation
import SwiftUI

struct GitRepoForksList: View {
    @ObservedObject var viewModelForksList: GitRepoForksListViewModel
    
    var gitRepoToFetch: GitRepoDTO
    
    var body: some View {
        
        VStack(alignment: .leading) {
            if self.viewModelForksList.repoForksInfo.count == 0 && self.viewModelForksList.errorWhenLoadingRepoForks == nil {
                LoadingRow(loadingText: String.localizedString(forKey: "txt_loading_forks"))
                    .padding(.init(top: 20, leading: 0, bottom: 0, trailing: 20))
            }
            
            if self.viewModelForksList.errorWhenLoadingRepoForks != nil {
                ErrorView(errorText: String.localizedString(forKey: "txt_error_load_forks"))
            }
            
            List(viewModelForksList.repoForksInfo) { forkInfo in
                if self.viewModelForksList.moreItemsToLoad(item: forkInfo) {
                    LoadingRow(loadingText: String.localizedString(forKey: "txt_fetching_more")).onAppear {
                        self.viewModelForksList.fetchRepoForks(for: self.gitRepoToFetch)
                    }
                } else {
                    GitForkDisplayRow(repoForkInfo: forkInfo)
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationBarTitle(gitRepoToFetch.repoName).onAppear {
            self.viewModelForksList.fetchRepoForks(for: self.gitRepoToFetch)
        }
    }
}
