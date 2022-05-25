//
//  MarvelsTests.swift
//  MarvelsTests
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import XCTest
@testable import Marvels

private class DummyClass {}

enum JSONLoaderError: Error {
    case fileNotFound 
}

extension String: Error {}

class MarvelsTests: XCTestCase {
    var mock: CharacterViewModel?
    var viewController: CharacterViewController!
    
    override func setUpWithError() throws {
        let responseJSON = try loadJSON(filename: "MockCharacters")
        let decoder = JSONDecoder()
        let jsonDecoded = try decoder.decode(CharacterModel.self, from: responseJSON)
        self.mock = CharacterViewModel(model: jsonDecoded)
        
        XCTAssertNoThrow(jsonDecoded)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: - Teste de conteúdo
    
    func testExample() throws {
        XCTAssertEqual(self.mock?.model?.status, "Ok")
        
        XCTAssertEqual(self.mock?.getThumbnail(row: 0, imageVariants: ImageVariants.portrait_uncanny), "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/portrait_uncanny.jpg")
        
        XCTAssertEqual(self.mock?.getThumbnail(row: 1, imageVariants: ImageVariants.portrait_uncanny), "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/portrait_uncanny.jpg")

        XCTAssertEqual(self.mock?.getThumbnail(row: 2, imageVariants: ImageVariants.portrait_uncanny), "http://i.annihil.us/u/prod/marvel/i/mg/9/10/4c003d76b5ec6/portrait_uncanny.jpg")
        
        XCTAssertEqual(self.mock?.getThumbnail(row: 3, imageVariants: ImageVariants.portrait_uncanny), "http://i.annihil.us/u/prod/marvel/i/mg/f/10/4ce5a06d6a8ad/portrait_uncanny.jpg")
        
        XCTAssertEqual(self.mock?.getThumbnail(row: 4, imageVariants: ImageVariants.portrait_uncanny), "http://i.annihil.us/u/prod/marvel/i/mg/b/c0/4c003c63deac8/portrait_uncanny.jpg")
        
        XCTAssertEqual(self.mock?.getThumbnail(row: 5, imageVariants: ImageVariants.portrait_uncanny), "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/portrait_uncanny.jpg")
        
        XCTAssertEqual(self.mock?.getName(row: 0),  "Countess")
        XCTAssertEqual(self.mock?.getName(row: 1),  "Joan the Mouse")
        XCTAssertEqual(self.mock?.getName(row: 2),  "La Nuit")
        XCTAssertEqual(self.mock?.getName(row: 3),  "Morph")
        XCTAssertEqual(self.mock?.getName(row: 4),  "Reavers")
        XCTAssertEqual(self.mock?.getName(row: 5),  "Sleeper")
    }
    
    //MARK: - Teste de preenchimento da view.
    
    func testView() throws {
        viewController = CharacterViewController()

        let view = viewController.characterView
        view.setData(viewModel: self.mock!)
        
        let tableView = view.tableView
        
        XCTAssertNotNil(tableView)

//        let visibleRows = tableView.indexPathsForVisibleRows
//        XCTAssert(visibleRows != nil)
//
//
//        let indexPath0 = IndexPath(item: 0, section: 0)
//        let cell0 = tableView.cellForRow(at: indexPath0)
//
//        XCTAssert(((tableView.indexPathsForVisibleRows?.contains(indexPath0)) != nil))
//        XCTAssert(cell0 != nil)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func loadJSON(filename: String) throws -> Data {
        let bundle = Bundle(for: DummyClass.self)
        guard let filePath = bundle.path(forResource: filename, ofType: "json") else {
            throw JSONLoaderError.fileNotFound
        }
        
        let jsonURL = URL(fileURLWithPath: filePath)
        
        return try Data(contentsOf: jsonURL)
    }
}
