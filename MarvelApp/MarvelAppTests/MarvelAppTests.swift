//
//  MarvelAppTests.swift
//  MarvelAppTests
//
//  Created by Rossana Rocha on 24/05/23.
//

import XCTest
@testable import MarvelApp

class MarvelAppTests: XCTestCase {

    var spiderMan: HomeCharacterModel?
    var ironMan: HomeCharacterModel?
    var captainAmerica: HomeCharacterModel?
    
    private var mockCharacters: [HomeCharacterModel] = [
                                  HomeCharacterModel(name: "Mickey", image: UIImage(), description: "Mickey Mouse"),
                                  HomeCharacterModel(name: "Donald", image: UIImage(), description: "Donald Duck"),
                                  HomeCharacterModel(name: "Goofy", image: UIImage(), description: ""),
                                  HomeCharacterModel(name: "Minnie", image: UIImage(), description: "Minnie Mouse"),
                                  HomeCharacterModel(name: "Stitch", image: UIImage(), description: "Experiment 626"),
                                  HomeCharacterModel(name: "Pooh", image: UIImage(), description: "Ursinho Pooh")]
    
    func testTopFiveLimit() {
        let viewModel = HomeViewModel(characters: mockCharacters)
        viewModel.getTopFive()
        let validLimit = viewModel.topFiveCharacters.count == 5
        XCTAssertTrue(validLimit)
    }
    
    func testRemoveDuplicates() {
        let viewModel = HomeViewModel(characters: mockCharacters)
        viewModel.getTopFive()
        let filteredCharacters = viewModel.homeCharacters.filter({!viewModel.topFiveCharacters.contains($0)})
        let validCharactersRemaining = filteredCharacters.count == 1
        XCTAssertTrue(validCharactersRemaining)
    }
}
