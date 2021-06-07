//
//  CharacterInfoHeaderViewTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

import XCTest

@testable import marvel_characters

class CharacterInfoHeaderViewTestCase: XCTestCase {
    
    var sut: CharacterInfoHeaderView!
    
    override func setUp() {
        sut = CharacterInfoHeaderView()
        sut.viewModel = CharacterInfoHeaderViewModel(with: Character.dummy())
    }

    override func tearDown() {
        sut = nil
    }
    
    func testViewHierarchy() {
        XCTAssertEqual(sut.subviews.count, 3)
    }
    
    func testRender() {
        XCTAssertEqual(sut.backgroundColor, .black)
        
        XCTAssertEqual(sut.backgroundImageView.contentMode, .scaleAspectFill)
        XCTAssertTrue(sut.backgroundImageView.layer.masksToBounds)
        
        XCTAssertEqual(sut.titleLabel.font, UIFont.systemFont(ofSize: 24, weight: .semibold))
        XCTAssertEqual(sut.titleLabel.textColor, .red)
        XCTAssertEqual(sut.titleLabel.numberOfLines, 0)
    }
    
    func testUpdateValue() {
        XCTAssertEqual(sut.titleLabel.text, "Test Character regular")
        XCTAssertNotNil(sut.backgroundImageView.image)
    }
}
