//
//  CharacterListViewControllerTests.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 05/04/23.
//

import Nimble
import XCTest
@testable import MarvelCharacters

final class CharacterListViewControllerTests: XCTestCase {
    
    func testStartLoading() {
        let sut = makeSut()
        
    }
    
    fileprivate func makeSut() -> SUT {
        let presenter = CharacterListPresenterProtocolMock()
        let networkClient = NetworkClientProtocolMock()
        let interactor = CharacterListInteractorProtocolMock()
        let dataSource = CharacterListDataSource()
        
        let viewController = CharacterListViewController(
            interactor: interactor,
            dataSource: dataSource
        )
        
        return SUT(
            interactor: interactor,
            presenter: presenter,
            viewController: viewController,
            networkClient: networkClient,
            dataSource: dataSource
        )
    }
    
    fileprivate struct SUT {
        let interactor: CharacterListInteractorProtocolMock
        let presenter: CharacterListPresenterProtocolMock
        let viewController: CharacterListViewController
        let networkClient: NetworkClientProtocolMock
        let dataSource: CharacterListDataSource
    }
}

