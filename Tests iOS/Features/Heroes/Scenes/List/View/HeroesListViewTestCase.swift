//
//  HeroesListViewTestCase.swift
//  Tests iOS
//
//  Created by Matheus Custódio on 27/07/22.
//

import XCTest

@testable import Marvel

class HeroesListViewTestCase: XCTestCase {
    
    var sut: HeroesListView!
    var mock: Hero!

    override func setUpWithError() throws {
        sut = HeroesListView()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testViewHierarchy() throws {
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertEqual(sut.contentView.subviews.count, 3)
        XCTAssertEqual(sut.stackView.subviews.count, 5)
    }

}
