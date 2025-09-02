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
        
    @EnvironmentObject var webService: GetRequestsGit
    
    @ObservedObject var viewModelGitReposList: GitReposListViewModel
    
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
                    LoadingRow(loadingText: String.localizedString(forKey: "txt_loading_repos"))
                        .id(UUID())
                        .fullWidthSeparators()
                }
                
                // Empty state, shown when no results
                if viewModelGitReposList.gitRepos.isEmpty, viewModelGitReposList.errorWhenLoadingRepos == nil, !viewModelGitReposList.isLoading {
                    Text("txt_no_results_for_search")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .fullWidthSeparators()
                }
                
                // Repo rows displayed from the loaded repos
                ForEach(viewModelGitReposList.gitRepos, id: \.id) { repo in
                    NavigationLink {
                        RepoDetail(gitRepoForDetailpage: repo)
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
            .navigationTitle(viewModelGitReposList.navigationBarTitle())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        LoginProfileView(viewModel: LoginProfileViewModel(getReposHelper: webService))
                    } label: {
                        Image(systemName: "person.crop.circle")
                            .font(.title.weight(.regular))
                            .foregroundStyle(.purple)
                    }
                }
            }
        }
        // System search field (iOS 15+), bound to your debounced query
        .searchable(text: $viewModelGitReposList.query, prompt: Text("search_bar_hint"))
        // Initial load when the view appears (non-blocking)
        .task {
            viewModelGitReposList.fetchRepos(for: viewModelGitReposList.query,  isSearching: false)
        }
    }
}

/// Preview for `GitReposList` View.
///
/// The view needs:
///  - a `GitReposListViewModel` (which depends on `GetRequestsGit`)
///  - a `GetRequestsGit` is injected as `@EnvironmentObject`
///
/// `PreviewWrapper` sets both up using `@StateObject`, so they behave like real app dependencies.
/// `webService`got injected  into the  environment for the preview!
struct GitReposList_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @StateObject private var webService: GetRequestsGit
        @StateObject private var viewModel: GitReposListViewModel
        
        init() {
            let ws = GetRequestsGit()
            _webService = StateObject(wrappedValue: ws)
            _viewModel = StateObject(wrappedValue: GitReposListViewModel(getReposHelper: ws))
        }
        
        var body: some View {
            GitReposList(viewModelGitReposList: viewModel)
                .environmentObject(webService)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
