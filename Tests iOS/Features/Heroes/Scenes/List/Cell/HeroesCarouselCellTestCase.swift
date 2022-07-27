//
//  HeroesCarouselCellTestCase.swift
//  Tests iOS
//
//  Created by Matheus Custódio on 27/07/22.
//

import XCTest

@testable import Marvel

class HeroesCarouselCellTestCase: XCTestCase {
    
    var sut: HeroesCarouselCell!
    var mock: Hero!

    override func setUpWithError() throws {
        sut = HeroesCarouselCell()
        mock = Hero(
                    id: 0,
                    name: "test",
                    description: "test",
                    thumbnail: .init(
                        path: "",
                        extension: ""
                    )
                )
    }

    override func tearDownWithError() throws {
        sut = nil
        mock = nil
    }

    func testViewHierarchy() throws {
        XCTAssertEqual(sut.subviews.count, 3)
        XCTAssertEqual(sut.textContainer.subviews.count, 4)
    }
    
    func testWithMock() throws {
        sut.configLayout(with: mock)
        XCTAssertEqual(sut.heroName.text, mock.name)
        XCTAssertEqual(sut.descriptionText.text, mock.description)
        mock.description = ""
        sut.configLayout(with: mock)
        XCTAssertEqual(sut.descriptionText.text, "Not Found!")
    }


}
