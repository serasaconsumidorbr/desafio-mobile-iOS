//
//  CharacterInfoViewControllerTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

import XCTest

@testable import marvel_characters

class CharacterInfoViewControllerTestCase: XCTestCase {
    
    var viewModelSpy: CharacterInfoViewModelSpy!
    var sut: CharacterInfoViewController!
    
    override func setUp() {
        viewModelSpy = CharacterInfoViewModelSpy(character: Character.dummy())
        sut = CharacterInfoViewController()
        sut.viewModel = viewModelSpy
    }

    override func tearDown() {
        viewModelSpy = nil
        sut = nil
    }
    
    func testInitial() {
        XCTAssertNotNil(sut.viewModel)
    }
    
    func testRender() {
        XCTAssertEqual(sut.tableView.backgroundColor, .black)
        XCTAssertEqual(sut.tableView.rowHeight, UITableView.automaticDimension)
        XCTAssertEqual(sut.tableView.estimatedRowHeight, 100)
        XCTAssertEqual(sut.tableView.separatorStyle, .none)
        XCTAssertFalse(sut.tableView.allowsSelection)
    }
    
    func testUpdate() {
        sut.update()
        XCTAssertEqual(sut.title, "Test Character regular")
        XCTAssertNotNil(sut.tableView.tableHeaderView)
    }
    
    func testTableDate() {
        XCTAssertEqual(sut.tableView.numberOfSections, 6)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testDidPressSection() {
        sut.didPressSection(0)
        XCTAssertTrue(viewModelSpy.toggleSectionWasCalled)
    }
}
