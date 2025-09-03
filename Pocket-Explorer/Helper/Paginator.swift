//
//  Paginator.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 26.01.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation

// TODO write tests
class Paginator {
    var pageToFetch: Int = 1
    
    let maxPagesToLoad = 5
    
    // items per page returned by GitHub
    let numberOfItemsPerPage = 30
    
    func updatePageToLoad(numberItemsLoaded: Int) {
        guard numberItemsLoaded > 0 else { return }
        pageToFetch += 1
    }
    
    func resetPage() {
        pageToFetch = 1
    }
    
    func moreItemsToLoad(numberItemsLoaded: Int) -> Bool {
        return numberItemsLoaded >= numberOfItemsPerPage && pageToFetch <= maxPagesToLoad
    }
}
