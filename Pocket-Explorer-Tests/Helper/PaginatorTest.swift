//
//  PaginatorTest.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 03.09.25.
//  Copyright © 2025 RB. All rights reserved.
//

import XCTest
@testable import Pocket_Explorer

class PaginatorTest: XCTestCase {
    
    var paginator: Paginator!
    
    override func setUp() {
        super.setUp()
        paginator = Paginator()
    }
    
    override func tearDown() {
        paginator = nil
        super.tearDown()
    }
    
    func testInitialPageIsOne() {
        XCTAssertEqual(paginator.pageToFetch, 1, "Paginator should start with page 1")
    }
    
    func testUpdatePageToLoadWithZeroItemsDoesNotChangePage() {
        paginator.updatePageToLoad(numberItemsLoaded: 0)
        XCTAssertEqual(paginator.pageToFetch, 1, "Page should not increment when zero items are loaded")
    }
    
    func testUpdatePageToLoadWithPositiveItemsIncrementsPage() {
        paginator.updatePageToLoad(numberItemsLoaded: 10)
        XCTAssertEqual(paginator.pageToFetch, 2, "Page should increment when items are loaded")
    }
    
    func testMultipleUpdatesIncrementPageCorrectly() {
        paginator.updatePageToLoad(numberItemsLoaded: 30)
        paginator.updatePageToLoad(numberItemsLoaded: 20)
        XCTAssertEqual(paginator.pageToFetch, 3, "Page should increment for each successful update")
    }
    
    func testResetPageSetsPageBackToOne() {
        paginator.updatePageToLoad(numberItemsLoaded: 30)
        paginator.updatePageToLoad(numberItemsLoaded: 20)
        paginator.resetPage()
        XCTAssertEqual(paginator.pageToFetch, 1, "Reset should set page back to 1")
    }
    
    func testMoreItemsToLoadReturnsTrueWhenThresholdMet() {
        paginator.updatePageToLoad(numberItemsLoaded: 30) // moves to page 2
        let result = paginator.shouldLoadMoreItems(numberItemsLoaded: 30)
        XCTAssertTrue(result, "Should return true when items per page threshold met and within max pages")
    }
    
    func testMoreItemsToLoadReturnsFalseWhenItemsLessThanPageSize() {
        let result = paginator.shouldLoadMoreItems(numberItemsLoaded: 20)
        XCTAssertFalse(result, "Should return false when items per page threshold not met")
    }
    
    func testMoreItemsToLoadReturnsFalseWhenMaxPagesExceeded() {
        paginator.pageToFetch = paginator.maxPagesToLoad + 1
        let result = paginator.shouldLoadMoreItems(numberItemsLoaded: 30)
        XCTAssertFalse(result, "Should return false when max pages exceeded")
    }
}
