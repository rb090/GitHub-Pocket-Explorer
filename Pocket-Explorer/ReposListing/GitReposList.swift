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
        
    @State private var query = ""
        
    var body: some View {
        let binding = Binding<String>(
            get: { self.query },
            set: { self.query = $0; self.textFieldChanged($0) }
        )
        
        return NavigationView {
            List {
                if viewModelGitReposList.errorWhenLoadingRepos != nil {
                    ErrorView(errorText: String.localizedString(forKey: "txt_error_load_repos"))
                }
                
                TextField("search_bar_hint", text: binding, onCommit:  {
                    self.viewModelGitReposList.fetchResults(for: self.query, isSearching: false)
                })
                
                if viewModelGitReposList.isLoading && viewModelGitReposList.errorWhenLoadingRepos == nil {
                    LoadingRow(loadingText: String.localizedString(forKey: "txt_loading_repos"))
                }
                
                if viewModelGitReposList.gitRepos.count == 0 && viewModelGitReposList.errorWhenLoadingRepos == nil && !viewModelGitReposList.isLoading {
                    Text("txt_no_results_for_search")
                        .font(.headline)
                        .foregroundColor(Color.red)
                }
                
                ForEach(viewModelGitReposList.gitRepos, id: \.id) { repo in
                    NavigationLink(destination: RepoDetail(gitRepoForDetailpage: repo)) {
                        GitReposRow(gitRepo: repo)
                    }
                }
                
                if viewModelGitReposList.moreItemsToLoad() && viewModelGitReposList.errorWhenLoadingRepos == nil {
                    LoadingRow(loadingText: String.localizedString(forKey: "txt_fetching_more")).onAppear {
                        self.viewModelGitReposList.fetchResults(for: self.query, isSearching: false)
                    }
                }
            }
            .navigationBarTitle(navigationBarTitle())
            .navigationBarItems(trailing:
                NavigationLink(destination: LoginProfileView(viewModel: LoginProfileViewModel(getReposHelper: webService)), label: {
                    Image(systemName:"person.crop.circle")
                    .font(Font.title.weight(.regular))
                    .foregroundColor(Color.purple)
                })
            )
        }.navigationViewStyle(StackNavigationViewStyle()).onAppear {
            self.viewModelGitReposList.fetchResults(for: self.query, isSearching: false)
        }
    }
    
    private func textFieldChanged(_ text: String) {
        viewModelGitReposList.searchDebounce.receive(text)
    }
    
    private func navigationBarTitle() -> String {
        return query.isEmpty ? String.localizedString(forKey: "title_git_repos") : query
    }
}

#if DEBUG
struct GitReposList_Previews : PreviewProvider {
    static var previews: some View {
        let webService = GetRequestsGit()
        let gitRepostViewModel = GitReposListViewModel(getReposHelper: webService)
        return GitReposList(viewModelGitReposList: gitRepostViewModel)
    }
}
#endif
