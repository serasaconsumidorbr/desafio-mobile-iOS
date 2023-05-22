//
//  CharactersViewModelTests.swift
//  MarvelCharactersTests
//
//  Created by iris on 22/05/23.
//

import XCTest
import RxSwift
import RxTest

@testable import MarvelCharacters

class CharactersViewModelTests: XCTestCase {
    var viewModel: CharactersViewModel!
    var charactersUseCaseMock: CharactersUseCaseMock!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        charactersUseCaseMock = CharactersUseCaseMock()
        viewModel = CharactersViewModel(charactersUseCase: charactersUseCaseMock)
    }

    override func tearDown() {
        disposeBag = nil
        charactersUseCaseMock = nil
        viewModel = nil
        super.tearDown()
    }

    func testGetCharacters() {
        let characters = [
            CharacterModel(id: "1", name: "Iron Man", description: "Genius billionaire playboy philanthropist", imagePath: "iron_man", imageExtension: "jpg"),
            CharacterModel(id: "2", name: "Captain America", description: "Super soldier and leader of the Avengers", imagePath: "captain_america", imageExtension: "jpg"),
            CharacterModel(id: "3", name: "Thor", description: "God of Thunder", imagePath: "thor", imageExtension: "jpg")
        ]
        viewModel.characters = characters

        XCTAssertEqual(viewModel.getCharacters(), characters)
    }

    func testGetCharacterAtIndex() {
        let characters = [
            CharacterModel(id: "1", name: "Iron Man", description: "Genius billionaire playboy philanthropist", imagePath: "iron_man", imageExtension: "jpg"),
            CharacterModel(id: "2", name: "Captain America", description: "Super soldier and leader of the Avengers", imagePath: "captain_america", imageExtension: "jpg"),
            CharacterModel(id: "3", name: "Thor", description: "God of Thunder", imagePath: "thor", imageExtension: "jpg")
        ]
        viewModel.characters = characters

        XCTAssertEqual(viewModel.getCharacter(at: 1), characters[1])
    }

    func testRetrieveCharacters() {
        let expectation = XCTestExpectation(description: "Retrieve characters")
        charactersUseCaseMock.retrieveCharactersExpectation = expectation

        viewModel.retrieveCharacters(asPagination: false)

        wait(for: [expectation], timeout: 1.0)

        if case .success(let asPagination) = try? viewModel.viewState.value() {
            XCTAssertEqual(asPagination, false, "O estado da view não foi atualizado corretamente")
        } else {
            XCTFail("O estado da view não foi atualizado corretamente")
        }
    }
}

class CharactersUseCaseMock: CharactersUseCaseType {
    var retrieveCharactersExpectation: XCTestExpectation?
    func execute(with requestModel: MarvelCharacters.CharactersRequestModel) -> RxSwift.Observable<Result<[MarvelCharacters.CharacterModel]?, Error>> {
       
        let characters = [
            CharacterModel(id: "1", name: "Iron Man", description: "Genius billionaire playboy philanthropist", imagePath: "iron_man", imageExtension: "jpg"),
            CharacterModel(id: "2", name: "Captain America", description: "Super soldier and leader of the Avengers", imagePath: "captain_america", imageExtension: "jpg"),
            CharacterModel(id: "3", name: "Thor", description: "God of Thunder", imagePath: "thor", imageExtension: "jpg")
        ]
        let result: Result<[CharacterModel]?, Error> = .success(characters)
        
        retrieveCharactersExpectation?.fulfill()
        return Observable.just(result)
    }
}
