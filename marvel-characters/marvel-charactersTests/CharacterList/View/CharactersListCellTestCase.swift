//
//  CharactersListCellTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

import XCTest

@testable import marvel_characters

class CharactersListCellTestCase: XCTestCase {
    
    var sut: CharactersListCell!
    
    override func setUp() {
        sut = CharactersListCell()
    }

    override func tearDown() {
        sut = nil
    }
    
    func testViewHierarchy() {
        XCTAssertEqual(sut.subviews.count, 2)
        XCTAssertEqual(sut.cardView.subviews.count, 4)
        XCTAssertEqual(sut.iconsStackView.subviews.count, 5)
    }
    
    func testRender() {
        XCTAssertEqual(sut.backgroundColor, .black)
        
        XCTAssertEqual(sut.cardView.backgroundColor, UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1))
        XCTAssertEqual(sut.cardView.layer.shadowColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor)
        XCTAssertEqual(sut.cardView.layer.shadowOpacity, 0.4)
        XCTAssertEqual(sut.cardView.layer.shadowRadius, 4)
        XCTAssertEqual(sut.cardView.layer.shadowOffset, .zero)
        XCTAssertTrue(sut.cardView.layer.shouldRasterize)
        XCTAssertEqual(sut.cardView.layer.rasterizationScale, UIScreen.main.scale)
        XCTAssertEqual(sut.cardView.layer.cornerRadius, 10)
        XCTAssertTrue(sut.cardView.clipsToBounds)
        
        XCTAssertEqual(sut.lineView.backgroundColor, .red)
        
        XCTAssertEqual(sut.titleLabel.font, UIFont.systemFont(ofSize: 24, weight: .semibold))
        XCTAssertEqual(sut.titleLabel.textColor, .red)
        
        XCTAssertEqual(sut.iconsStackView.axis, .horizontal)
        XCTAssertEqual(sut.iconsStackView.alignment, .leading)
        XCTAssertEqual(sut.iconsStackView.distribution, .fill)
        XCTAssertEqual(sut.iconsStackView.spacing, 16)
        
        XCTAssertEqual(sut.comicIconImageView.contentMode, .scaleAspectFit)
        XCTAssertEqual(sut.comicIconImageView.tintColor, .white)
        XCTAssertTrue(sut.comicIconImageView.isHidden)
        XCTAssertNotNil(sut.comicIconImageView.image)
        
        XCTAssertEqual(sut.storiesIconImageView.contentMode, .scaleAspectFit)
        XCTAssertEqual(sut.storiesIconImageView.tintColor, .white)
        XCTAssertTrue(sut.storiesIconImageView.isHidden)
        XCTAssertNotNil(sut.storiesIconImageView.image)
        
        XCTAssertEqual(sut.eventIconImageView.contentMode, .scaleAspectFit)
        XCTAssertEqual(sut.eventIconImageView.tintColor, .white)
        XCTAssertTrue(sut.eventIconImageView.isHidden)
        XCTAssertNotNil(sut.eventIconImageView.image)
        
        XCTAssertEqual(sut.seriesIconImageView.contentMode, .scaleAspectFit)
        XCTAssertEqual(sut.seriesIconImageView.tintColor, .white)
        XCTAssertTrue(sut.seriesIconImageView.isHidden)
        XCTAssertNotNil(sut.seriesIconImageView.image)
        
        XCTAssertEqual(sut.urlIconImageView.contentMode, .scaleAspectFit)
        XCTAssertEqual(sut.urlIconImageView.tintColor, .white)
        XCTAssertTrue(sut.urlIconImageView.isHidden)
        XCTAssertNotNil(sut.urlIconImageView.image)
        
        XCTAssertEqual(sut.arrowIconImageView.contentMode, .scaleAspectFit)
        XCTAssertEqual(sut.arrowIconImageView.tintColor, .gray)
        XCTAssertNotNil(sut.urlIconImageView.image)
    }
    
    func testPrepareForReuse() {
        sut.prepareForReuse()
        XCTAssertNil(sut.titleLabel.text)
        XCTAssertTrue(sut.comicIconImageView.isHidden)
        XCTAssertTrue(sut.seriesIconImageView.isHidden)
        XCTAssertTrue(sut.storiesIconImageView.isHidden)
        XCTAssertTrue(sut.eventIconImageView.isHidden)
        XCTAssertTrue(sut.urlIconImageView.isHidden)
    }
    
    func testSetupData() {
        let character = Character.dummy()
        sut.setupData(with: character)
        
        XCTAssertEqual(sut.titleLabel.text, "Test Character regular")
        XCTAssertFalse(sut.comicIconImageView.isHidden)
        XCTAssertFalse(sut.seriesIconImageView.isHidden)
        XCTAssertFalse(sut.storiesIconImageView.isHidden)
        XCTAssertFalse(sut.eventIconImageView.isHidden)
        XCTAssertFalse(sut.urlIconImageView.isHidden)
    }
}
