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
    
    var searchDebounce = Debouncer<String>(0.6)
    
    @Published var gitRepos = [GitRepoDTO]()
    @Published var errorWhenLoadingRepos: Error?
    
    @Published var isLoading: Bool = false
    
    let pagingHelper: PagingHelper
         
    init(getReposHelper: GetRequestsGit, urlServiceClass: GitHubUrls = GitHubUrls(), pagingHelper: PagingHelper = PagingHelper()) {
        getGithubReposService = getReposHelper  
        urlService = urlServiceClass
        self.pagingHelper = pagingHelper
        
        searchDebounce.on { [weak self] query in
            self?.fetchResults(for: query, isSearching: true)
        }
    }
    
    func fetchRepos(for query: String?, isSearching: Bool) {
        guard isLoading == false else { return }

        isLoading = true
        
        if isSearching {
            pagingHelper.resetPage()
        }
        
        guard let urlForRequest = urlService.loadReposUrl(for: query, page: pagingHelper.pageToFetch) else {
            // TODO create error object and show up info
            return
        }
        
        getGithubReposService.getJsonData(url: URL(string: urlForRequest)) { [weak self] (result: Result<GitHubRepoListDTO, Error>) in
            self?.isLoading = false
            switch result {
            case .success(let listGithubRepos):
                let listItems = listGithubRepos.listItems
                
                if isSearching {
                    self?.gitRepos = listItems
                } else {
                    self?.gitRepos.append(contentsOf: listItems)
                }
                self?.errorWhenLoadingRepos = nil
                self?.pagingHelper.updatePageToLoad(numberItemsLoaded: listItems.count)
            case .failure(let error):
                self?.errorWhenLoadingRepos = error
                print("error: \(error)")
            }
        }
    }
    
    func fetchResults(for query: String?, isSearching: Bool) {
        query?.isEmpty == true ? fetchRepos(for: nil, isSearching: isSearching) : fetchRepos(for: query, isSearching: isSearching)
    }
    
    func moreItemsToLoad() -> Bool {
        return pagingHelper.moreItemsToLoad(numberItemsLoaded: gitRepos.count)
    }
}
