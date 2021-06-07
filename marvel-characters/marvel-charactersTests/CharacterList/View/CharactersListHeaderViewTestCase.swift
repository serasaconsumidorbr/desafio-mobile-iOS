//
//  CharactersListHeaderViewTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

import XCTest

@testable import marvel_characters

class CharactersListHeaderViewTestCase: XCTestCase {
    
    var sut: CharactersListHeaderView!
    
    override func setUp() {
        let viewModel = CharactersListViewModel(
            service: CharactersListServiceStub(success: CharacterDataWrapper.dummy())
        )
        viewModel.getCharactersList {}
        sut = CharactersListHeaderView()
        sut.viewModel = viewModel
    }

    override func tearDown() {
        sut = nil
    }
    
    func testViewHierarchy() {
        XCTAssertEqual(sut.subviews.count, 1)
    }
    
    func testRender() {
        XCTAssertEqual(sut.backgroundColor, .black)
        XCTAssertFalse(sut.collectionView.showsHorizontalScrollIndicator)
    }
    
    func testInitCollectionView() {
        XCTAssertEqual(sut.collectionView.numberOfSections, 1)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 5)
    }
}
