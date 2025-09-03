//
//  GitRepoForksListViewModel.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 24.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class GitRepoForksListViewModel: ObservableObject {
    let getGithubReposService: GetRequestsGit
    
    @Published var repoForksInfo = [RepoForksDTO]()
    @Published var errorWhenLoadingRepoForks: Error?
    
    @Published var isLoading: Bool = false
    
    let pagingHelper: Paginator
    
    init(webService: GetRequestsGit, pagingHelper: Paginator = Paginator()) {
        getGithubReposService = webService
        self.pagingHelper = pagingHelper
    }
    
    @MainActor
    func fetchRepoForks(for repo: GitRepoDTO) {
        guard isLoading == false,
              pagingHelper.pageToFetch <= pagingHelper.maxPagesToLoad,
              let forksUrlAppedingPage = repo.forksUrl?.absoluteString.appending("?page=\(pagingHelper.pageToFetch)")
        else {
            return
        }
        
        Task {
            let reposForksResult: Result<[RepoForksDTO], Error> = await getGithubReposService.getJsonData(url: URL(string: forksUrlAppedingPage))
            
            switch reposForksResult {
            case .success(let repoForks):
                repoForksInfo.append(contentsOf: repoForks)
                pagingHelper.updatePageToLoad(numberItemsLoaded: repoForks.count)
                errorWhenLoadingRepoForks = nil
            case .failure(let error):
                errorWhenLoadingRepoForks = error
                print("error: \(error)")
            }
        }
    }
    
    func isLastArrayItem(item: RepoForksDTO) -> Bool {
        guard repoForksInfo.count > 0 else { return true }
        let lastArrayItem = repoForksInfo[repoForksInfo.count - 1]
        return item.id == lastArrayItem.id
    }
    
    func moreItemsToLoad(item: RepoForksDTO) -> Bool {
        return isLastArrayItem(item: item) && pagingHelper.shouldLoadMoreItems(numberItemsLoaded: repoForksInfo.count)
    }
}
