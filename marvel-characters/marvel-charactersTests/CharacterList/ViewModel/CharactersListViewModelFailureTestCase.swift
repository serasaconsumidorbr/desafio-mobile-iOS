//
//  CharactersListViewModelFailureTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 06/06/21.
//

import XCTest

@testable import marvel_characters

class CharactersListViewModelFailureTestCase: XCTestCase {

    var sut: CharactersListViewModel!
    
    override func setUp() {
        let service = CharactersListServiceStub(error: .explicitlyCancelled)
        sut = CharactersListViewModel(service: service)
    }

    override func tearDown() {
        sut = nil
    }

    func testGetCharactersListError() {
        var completionWasCalled: Bool = false
        sut.getCharactersList {
            completionWasCalled = true
        }
        XCTAssertTrue(completionWasCalled)
        XCTAssertEqual(sut.getNumberOfCharacters(), 0)
        XCTAssertEqual(sut.getNumberOfFirstsCharacters(), 0)
    }
}
