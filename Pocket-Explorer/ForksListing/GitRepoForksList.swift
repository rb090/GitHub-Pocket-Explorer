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
        List {
            // Initial loading state when there is no data or error.
            if viewModelForksList.repoForksInfo.isEmpty, viewModelForksList.errorWhenLoadingRepoForks == nil {
                LoadingRow(loadingText: String.localizedString(forKey: "txt_loading_forks"))
                    .id(UUID())
                    .fullWidthSeparators()
            }
            
            // We got an error, we show an error hint!
            if viewModelForksList.errorWhenLoadingRepoForks != nil {
                ErrorView(errorText: String.localizedString(forKey: "txt_error_load_forks"))
                    .fullWidthSeparators()
            }
            
            // Display the list and handle infinite loading
            ForEach(viewModelForksList.repoForksInfo) { forkInfo in
                if viewModelForksList.moreItemsToLoad(item: forkInfo) {
                    LoadingRow(loadingText: String.localizedString(forKey: "txt_fetching_more"))
                        .id(UUID())
                        .fullWidthSeparators()
                        .task {
                            viewModelForksList.fetchRepoForks(for: gitRepoToFetch)
                        }
                } else {
                    GitForkDisplayRow(repoForkInfo: forkInfo)
                        .fullWidthSeparators()
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle(gitRepoToFetch.repoName)
        .task {
            viewModelForksList.fetchRepoForks(for: gitRepoToFetch)
        }
    }
}
