//
//  CharactersListHeaderCellTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

import XCTest

@testable import marvel_characters

class CharactersListHeaderCellTestCase: XCTestCase {
    
    var sut: CharactersListHeaderCell!
    
    override func setUp() {
        sut = CharactersListHeaderCell()
    }

    override func tearDown() {
        sut = nil
    }
    
    func testViewHierarchy() {
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertEqual(sut.characterImageView.subviews.count, 3)
    }
    
    func testRender() {
        XCTAssertEqual(sut.backgroundColor, .black)
        
        XCTAssertEqual(sut.backgroundTitleView.backgroundColor, UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1))
        
        XCTAssertEqual(sut.titleLabel.font, UIFont.systemFont(ofSize: 16, weight: .semibold))
        XCTAssertEqual(sut.titleLabel.textColor, .red)
        XCTAssertEqual(sut.titleLabel.numberOfLines, 3)
    }
    
    func testSetupData() {
        let character = Character.dummy(type: .collection)
        sut.setupData(with: character)
        
        XCTAssertEqual(sut.titleLabel.text, "Test Character collection")
    }
}
