//
//  CharacterInfoViewModelTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 06/06/21.
//

import XCTest

@testable import marvel_characters

class CharacterInfoViewModelTestCase: XCTestCase {

    var sut: CharacterInfoViewModel!
    
    override func setUp() {
        sut = CharacterInfoViewModel(character: Character.dummy())
    }

    override func tearDown() {
        sut = nil
    }

    func testInit() {
        XCTAssertNotNil(sut.selectedCharacter)
        XCTAssertEqual(sut.getNumberOfSections(), 6)
    }
    
    func testSectionItem() {
        let descriptionSection = sut.getSectionAt(0)
        XCTAssertEqual(descriptionSection?.type, .description)
        
        let comicsSection = sut.getSectionAt(1)
        XCTAssertEqual(comicsSection?.type, .comics)
        
        let serieSection = sut.getSectionAt(2)
        XCTAssertEqual(serieSection?.type, .series)
        
        let storieSection = sut.getSectionAt(3)
        XCTAssertEqual(storieSection?.type, .stories)
        
        let eventSection = sut.getSectionAt(4)
        XCTAssertEqual(eventSection?.type, .events)
        
        let urlSection = sut.getSectionAt(5)
        XCTAssertEqual(urlSection?.type, .urls)
    }
    
    func testToggleSection() {
        guard let section = sut.getSectionAt(0) else {
            XCTFail("Section was not accessed")
            return
        }
        XCTAssertFalse(section.isOpen)
        sut.toggleSectionAt(0)
        guard let sectionAfterToggle = sut.getSectionAt(0) else {
            XCTFail("Section was not accessed")
            return
        }
        XCTAssertTrue(sectionAfterToggle.isOpen)
        sut.toggleSectionAt(0)
        guard let sectionAfterTrueToggle = sut.getSectionAt(0) else {
            XCTFail("Section was not accessed")
            return
        }
        XCTAssertFalse(sectionAfterTrueToggle.isOpen)
    }
    
    func testNumberOfRowsInClosedSection() {
        let rows = sut.getNumberOfRowInSection(2)
        XCTAssertEqual(rows, 0)
    }
    
    func testNumberOfRowsInOpenedSection() {
        sut.toggleSectionAt(2)
        let rows = sut.getNumberOfRowInSection(2)
        XCTAssertEqual(rows, 1)
    }
    
    func testGetItem() {
        let item = sut.getItemAt(IndexPath(item: 0, section: 1))
        XCTAssertEqual(item?.title, "Comic Summary")
        XCTAssertEqual(item?.type, .text)
    }
}
