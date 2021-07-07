//
//  CharactersMarvelTests.swift
//  CharactersMarvelTests
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import XCTest
import Combine
@testable import CharactersMarvel

class CharactersMarvelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func testValidConstantsInAPI() throws {
        XCTAssertEqual(API.mavenLimit(), 20)
        XCTAssertEqual(API.urlScheme(), "http")
        XCTAssertEqual(API.urlHost(), "gateway.marvel.com")
        XCTAssertEqual(API.mavenTS(), "1")
    }
    
    func testMavenViewModelGetAllCharactersSuccess() {
        let mavenRepository = MavenRepositoryMock(isFailed: false)
        let mavenViewModel = MarvelViewModel(repository: mavenRepository)
        var characters = [Character]()
        var _error: Error?
        var _loading: Bool = false
        
        mavenViewModel.$state.sink { value in
            
            switch value {
            case .loading:
                _loading = true
                break
            case .failed(let error):
                _loading = false
                _error = error
                break
            case .success(let value):
                _loading = false
                characters = value
                break
            }
            
        }.store(in: &cancellables)
        
        XCTAssertTrue(_loading)
        
        mavenViewModel.getAllCharacters(page: nil)
        
        XCTAssertFalse(_loading)
        
        XCTAssertNil(_error)
        XCTAssertEqual(characters.count, 3)
        XCTAssertEqual(characters.first?.name, "Adam Warlock")
        XCTAssertEqual(characters.last?.name, "Alex Wilder")
        
        XCTAssertEqual(characters.last?.modified?.dateFormat(formatTo: "yyyy-MM-dd'T'HH:mm-ssZ",
                                                             formatFrom: "'Atualizado em 'dd' de 'MMMM' de 'yyyy"),
                       "Atualizado em 31 de dezembro de 1969")
        
        XCTAssertEqual(characters.first?.modified?.dateFormat(formatTo: "yyyy-MM-dd'T'HH:mm-ssZ",
                                                              formatFrom: "'Atualizado em 'dd' de 'MMMM' de 'yyyy"),
                       "Atualizado em 07 de agosto de 2013")
        
    }
    
    func testMavenViewModelGetAllCharactersFail() {
        let mavenRepository = MavenRepositoryMock(isFailed: true)
        let mavenViewModel = MarvelViewModel(repository: mavenRepository)
        var characters = [Character]()
        var _error: Error?
        var _loading: Bool = false
        
        mavenViewModel.$state.sink { value in
            
            switch value {
            case .loading:
                _loading = true
                break
            case .failed(let error):
                _loading = false
                _error = error
                break
            case .success(let value):
                _loading = false
                characters = value
                break
            }
            
        }.store(in: &cancellables)
        
        XCTAssertTrue(_loading)
        
        mavenViewModel.getAllCharacters(page: nil)
        
        XCTAssertFalse(_loading)
        XCTAssertNotNil(_error)
        XCTAssertEqual(characters.count, 0)
        XCTAssertEqual(_error?.localizedDescription, "Ocorreu um error ao tentar buscar os dados")
        
    }
}
