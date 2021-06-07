//
//  CharacterInfoHeaderViewModelTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

import XCTest

@testable import marvel_characters

class CharacterInfoHeaderViewModelTestCase: XCTestCase {

    var sut: CharacterInfoHeaderViewModel!
    
    override func setUp() {
        sut = CharacterInfoHeaderViewModel(with: Character.dummy())
    }

    override func tearDown() {
        sut = nil
    }
    
    func testGetCharacterName() {
        let name = sut.getCharacterName()
        XCTAssertEqual(name, "Test Character regular")
    }
    
    func testGetCharacterImageInfos() {
        let infos = sut.getCharacterImageInfos()
        XCTAssertEqual(infos.path, "path")
        XCTAssertEqual(infos.pathExtension, "extension")
    }
}
