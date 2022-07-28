//
//  HeroesTableViewCellTestCase.swift
//  Tests iOS
//
//  Created by Matheus Custódio on 27/07/22.
//

import XCTest

class HeroesTableViewCellTestCase: XCTestCase {

    var sut: HeroesTableViewCell!
    var mock: Hero!

    override func setUpWithError() throws {
        sut = HeroesTableViewCell()
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
        XCTAssertEqual(sut.textContainer.subviews.count, 2)
    }
    
    func testWithMock() throws {
        sut.configLayout(with: mock)
        XCTAssertEqual(sut.heroName.text, "Name: \(mock.name)")
        XCTAssertEqual(sut.descriptionText.text, "Description: \(mock.description)")
        mock.description = ""
        sut.configLayout(with: mock)
        XCTAssertEqual(sut.descriptionText.text, "Description: Not Found!")
    }


}
