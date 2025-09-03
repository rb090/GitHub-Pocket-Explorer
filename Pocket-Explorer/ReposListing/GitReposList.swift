//
//  GitReposList.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 23.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation
import SwiftUI

struct GitReposList: View {
    
    private let webService: GetRequestsGit
    @StateObject var viewModelGitReposList: GitReposListViewModel
    
    init(webService: GetRequestsGit) {
        self.webService = webService
        _viewModelGitReposList = StateObject(wrappedValue: GitReposListViewModel(webService: webService))
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Show error in case loading repos request failed
                if viewModelGitReposList.errorWhenLoadingRepos != nil {
                    ErrorView(errorText: String(localized: "txt_error_load_repos"))
                        .fullWidthSeparators()
                }
                
                // Loading state
                if viewModelGitReposList.errorWhenLoadingRepos == nil, viewModelGitReposList.isLoading {
                    LoadingRow(loadingText: String(localized: "txt_loading_repos"))
                        .id(UUID())
                        .fullWidthSeparators()
                }
                
                // Empty state, shown when no results
                if viewModelGitReposList.gitRepos.isEmpty, viewModelGitReposList.errorWhenLoadingRepos == nil, !viewModelGitReposList.isLoading {
                    Text("txt_no_results_for_search")
                        .font(.headline)
                        .foregroundStyle(DesignSystem.AppColors.primary)
                        .frame(maxWidth: .infinity, minHeight: 45, alignment: .leading)
                        .fullWidthSeparators()
                }
                
                // Repo rows displayed from the loaded repos
                ForEach(viewModelGitReposList.gitRepos, id: \.id) { repo in
                    NavigationLink {
                        RepoDetail(webService: webService, gitRepoForDetailpage: repo)
                    } label: {
                        GitReposRow(gitRepo: repo)
                    }
                    .fullWidthSeparators()
                }
                
                // Infinite scroll: load more when the loading row comes into view until a page max is reached!
                if viewModelGitReposList.moreItemsToLoad(), viewModelGitReposList.errorWhenLoadingRepos == nil {
                    LoadingRow(loadingText: String(localized: "txt_fetching_more"))
                        .id(UUID())
                        .fullWidthSeparators()
                        .task {
                            viewModelGitReposList.fetchRepos( for: viewModelGitReposList.query, isSearching: false)
                        }
                }
            }
            .listStyle(.plain)
            .navigationTitle(String(localized: "title_git_repos"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        LoginProfileView(webService: webService)
                    } label: {
                        Image(systemName: "person.crop.circle").foregroundStyle(DesignSystem.AppColors.primary)
                    }
                }
            }
        }
        // System search field (iOS 15+), bound to your debounced query
        .searchable(text: $viewModelGitReposList.query, prompt: Text("search_bar_hint"))
        .tint(DesignSystem.AppColors.primary)
        // Initial load when the view appears (non-blocking)
        .task {
            viewModelGitReposList.fetchRepos(for: viewModelGitReposList.query,  isSearching: false)
        }
    }
}


#Preview("GitReposList") {
    GitReposList(webService: GetRequestsGit())
}
