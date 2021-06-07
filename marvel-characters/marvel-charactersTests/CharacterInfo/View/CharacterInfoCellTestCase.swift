//
//  CharacterInfoCellTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

import XCTest

@testable import marvel_characters

class CharacterInfoCellTestCase: XCTestCase {
    
    var sut: CharacterInfoCell!
    
    override func setUp() {
        sut = CharacterInfoCell()
    }

    override func tearDown() {
        sut = nil
    }
    
    func testViewHierarchy() {
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertEqual(sut.cardView.subviews.count, 1)
    }
    
    func testRender() {
        XCTAssertEqual(sut.backgroundColor, .black)
        
        XCTAssertEqual(sut.cardView.backgroundColor, UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1))
        XCTAssertEqual(sut.cardView.layer.cornerRadius, 10)
        
        XCTAssertEqual(sut.titleLabel.textColor, .white)
        XCTAssertEqual(sut.titleLabel.numberOfLines, 0)
        XCTAssertEqual(sut.titleLabel.font, UIFont.systemFont(ofSize: 20, weight: .semibold))
    }
    
    func testUpdateValue() {
        sut.setupData(with: CharacterInfo(title: "title", type: .text))
        XCTAssertEqual(sut.titleLabel.text, "title")
        XCTAssertEqual(sut.titleLabel.textAlignment, .left)
    }
    
    func testPrepareForReuse() {
        sut.prepareForReuse()
        XCTAssertNil(sut.titleLabel.text)
    }
}
