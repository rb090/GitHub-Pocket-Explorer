//
//  GitReposListViewModel.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 23.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class GitReposListViewModel: ObservableObject {
    let getGithubReposService: GetRequestsGit
    let urlService: GitHubUrls
    
    @Published var query = ""
    
    @Published var gitRepos = [GitRepoDTO]()
    @Published var errorWhenLoadingRepos: Error?
    
    @Published var isLoading: Bool = false
    
    let pagingHelper: Paginator
    
    private var cancellables = Set<AnyCancellable>()
    
    init(webService: GetRequestsGit, urlServiceClass: GitHubUrls = GitHubUrls(), pagingHelper: Paginator = Paginator()) {
        getGithubReposService = webService
        urlService = urlServiceClass
        self.pagingHelper = pagingHelper

        // Listen to changes in the `query` property.
        // - `.removeDuplicates()` ensures the pipeline only reacts when the value actually changes. Avoids unnecessary API calls when the user ends up typing the same thing again.
        // - `.debounce(...)` waits 500ms after the last keystroke before emitting, to avoid firing on every character typed.
        // - `.sink { ... }` subscriber, calls `fetchRepos` with the latest debounced query.
        // - The subscription is stored in `cancellables` to keep it alive for the lifetime of the object.
        $query
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] q in
                Task { @MainActor in
                    self?.fetchRepos(for: self?.query, isSearching: true)
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func fetchRepos(for query: String?, isSearching: Bool) {
        guard isLoading == false else { return }
        
        isLoading = true
        
        if isSearching {
            pagingHelper.resetPage()
        }
        
        guard let urlForRequest = urlService.loadReposUrl(for: query, page: pagingHelper.pageToFetch) else {
            // TODO create error object and show up info
            isLoading = false
            return
        }
        
        Task {
            let githubReposListResult: Result<GitHubRepoListDTO, Error> = await getGithubReposService.getJsonData(url: URL(string: urlForRequest))
            
            isLoading = false
            switch githubReposListResult {
            case .success(let listGithubRepos):
                let listItems = listGithubRepos.listItems
                
                if isSearching {
                    gitRepos = listItems
                } else {
                    gitRepos.append(contentsOf: listItems)
                }
                
                errorWhenLoadingRepos = nil
                pagingHelper.updatePageToLoad(numberItemsLoaded: listItems.count)
            case .failure(let error):
                errorWhenLoadingRepos = error
                print("error: \(error)")
            }
        }
    }
    
    func moreItemsToLoad() -> Bool {
        pagingHelper.moreItemsToLoad(numberItemsLoaded: gitRepos.count)
    }
}
