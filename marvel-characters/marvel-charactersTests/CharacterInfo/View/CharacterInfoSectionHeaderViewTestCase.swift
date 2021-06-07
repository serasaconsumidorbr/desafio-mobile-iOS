//
//  CharacterInfoSectionHeaderViewTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

import XCTest

@testable import marvel_characters

class CharacterInfoSectionHeaderViewTestCase: XCTestCase {
    
    var delegateMock: CharacterInfoSectionHeaderViewDelegateMock!
    var sut: CharacterInfoSectionHeaderView!
    
    override func setUp() {
        delegateMock = CharacterInfoSectionHeaderViewDelegateMock()
        sut = CharacterInfoSectionHeaderView()
        sut.delegate = delegateMock
        sut.section = CharacterInfoSectionHeader(type: .comics)
    }

    override func tearDown() {
        delegateMock = nil
        sut = nil
    }
    
    func testViewHierarchy() {
        XCTAssertEqual(sut.subviews.count, 3)
    }
    
    func testRender() {
        XCTAssertEqual(sut.backgroundColor, .black)
        
        XCTAssertEqual(sut.iconImageView.contentMode, .scaleAspectFit)
        XCTAssertEqual(sut.iconImageView.tintColor, .red)
        
        XCTAssertEqual(sut.arrowImageView.contentMode, .scaleAspectFit)
        XCTAssertEqual(sut.arrowImageView.tintColor, .lightGray)
        
        XCTAssertEqual(sut.titleLabel.textColor, .white)
        XCTAssertEqual(sut.titleLabel.numberOfLines, 0)
        XCTAssertEqual(sut.titleLabel.font, UIFont.systemFont(ofSize: 18, weight: .semibold))
    }
    
    func testUpdateValue() {
        XCTAssertEqual(sut.iconImageView.image, CharacterInfoSectionHederType.comics.image)
        XCTAssertEqual(sut.titleLabel.text, "Comics")
    }
    
    func testDelegate() {
        sut.sendActions(for: .touchUpInside)
        XCTAssertTrue(delegateMock.didPressSectionWasCalled)
    }
}
