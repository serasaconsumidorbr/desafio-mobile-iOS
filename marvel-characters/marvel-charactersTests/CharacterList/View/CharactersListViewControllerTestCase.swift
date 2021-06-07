//
//  CharactersListViewControllerTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

import XCTest

@testable import marvel_characters

class CharactersListViewControllerTestCase: XCTestCase {
    
    var viewModelSpy: CharactersListViewModelSpy!
    var sut: CharactersListViewController!
    
    override func setUp() {
        viewModelSpy = CharactersListViewModelSpy(
            service: CharactersListServiceStub(success: CharacterDataWrapper.dummy())
        )
        sut = CharactersListViewController(viewModel: viewModelSpy)
    }

    override func tearDown() {
        viewModelSpy = nil
        sut = nil
    }
    
    func testInitial() {
        XCTAssertNotNil(sut.viewModel)
    }
    
    func testRender() {
        XCTAssertEqual(sut.tableView.rowHeight, 100)
        XCTAssertEqual(sut.tableView.separatorStyle, .none)
        
        XCTAssertEqual(sut.loader.color, .white)
        XCTAssertEqual(sut.loader.style, .large)
        XCTAssertTrue(sut.loader.hidesWhenStopped)
    }
    
    func testUpdate() {
        XCTAssertNotNil(sut.tableView.tableHeaderView)
        XCTAssertNil(sut.tableView.tableFooterView)
        XCTAssertEqual(sut.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
        XCTAssertEqual(viewModelSpy.requestCalledCount, 1)
    }
    
    func testLoadMoreItens() {
        sut.loadMoreItems()
        XCTAssertEqual(viewModelSpy.requestCalledCount, 2)
    }
}
