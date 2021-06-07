//
//  CharactersListViewModelTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 06/06/21.
//

import XCTest

@testable import marvel_characters

class CharactersListViewModelTestCase: XCTestCase {

    var sut: CharactersListViewModel!
    
    override func setUp() {
        let service = CharactersListServiceStub(success: CharacterDataWrapper.dummy())
        sut = CharactersListViewModel(service: service)
    }

    override func tearDown() {
        sut = nil
    }

    func testInit() {
        XCTAssertNotNil(sut.service)
        XCTAssertFalse(sut.isLoadingRequest)
        XCTAssertFalse(sut.hasItemsToLoad)
        XCTAssertEqual(sut.maxNumberOfFirstItems, 5)
        XCTAssertEqual(sut.getNumberOfCharacters(), 0)
        XCTAssertEqual(sut.getNumberOfFirstsCharacters(), 0)
    }
    
    func testGetCharactersList() {
        var completionWasCalled: Bool = false
        sut.getCharactersList {
            completionWasCalled = true
        }
        XCTAssertTrue(completionWasCalled)
        XCTAssertEqual(sut.getNumberOfCharacters(), 3)
        XCTAssertEqual(sut.getNumberOfFirstsCharacters(), 5)
    }
    
    func testGetCharacterItem() {
        sut.getCharactersList {}
        XCTAssertEqual(sut.getNumberOfCharacters(), 3)
        let character = sut.getCharacterAt(0)
        XCTAssertEqual(character?.id, 12345)
        XCTAssertEqual(character?.name, "Test Character regular")
        XCTAssertEqual(character?.characterDescription, "Test Character Description regular")
    }
    
    func testGetFirstsCharacterItem() {
        sut.getCharactersList {}
        XCTAssertEqual(sut.getNumberOfFirstsCharacters(), 5)
        let character = sut.getFirstsCharacterAt(0)
        XCTAssertEqual(character?.id, 12345)
        XCTAssertEqual(character?.name, "Test Character collection")
        XCTAssertEqual(character?.characterDescription, "Test Character Description collection")
    }
}
