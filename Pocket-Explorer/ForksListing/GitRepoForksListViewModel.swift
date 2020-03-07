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
    
    private var isLoading: Bool = false
    
    let pagingHelper: PagingHelper
    
    init(getReposHelper: GetRequestsGit, pagingHelper: PagingHelper = PagingHelper()) {
        getGithubReposService = getReposHelper
        self.pagingHelper = pagingHelper
    }
    
    func fetchRepoForks(for repo: GitRepoDTO) {
        guard isLoading == false, pagingHelper.pageToFetch <= pagingHelper.maxPagesToLoad, let forksUrlAppedingPage = repo.forksUrl?.absoluteString.appending("?page=\(pagingHelper.pageToFetch)") else { return }
        
        getGithubReposService.getJsonData(url: URL(string: forksUrlAppedingPage)) { [weak self] (result: Result<[RepoForksDTO], Error>) in
            switch result {
            case .success(let repoForks):
                self?.repoForksInfo.append(contentsOf: repoForks)
                self?.pagingHelper.updatePageToLoad(numberItemsLoaded: repoForks.count)
                self?.errorWhenLoadingRepoForks = nil
            case .failure(let error):
                self?.errorWhenLoadingRepoForks = error
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
        return isLastArrayItem(item: item) && pagingHelper.moreItemsToLoad(numberItemsLoaded: repoForksInfo.count)
    }
}
