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
    
    func testPullToRefreshAction() {
        let sut = makeSut()
        
        sut.viewController.refresh("")
        
        expect(sut.interactor.calledMethods)
            .to(equal([.reloadCharacters]))
    }
    
    fileprivate func makeSut() -> SUT {
        let presenter = CharacterListPresenterProtocolMock()
        let networkClient = NetworkClientProtocolMock()
        let interactor = CharacterListInteractorProtocolMock()
        let dataSource = CharacterListDataSource()
        let router = CharacterListRouterProtocolMock()
        
        let viewController = CharacterListViewController(
            interactor: interactor,
            dataSource: dataSource,
            router: router
        )
        
        return SUT(
            interactor: interactor,
            presenter: presenter,
            viewController: viewController,
            networkClient: networkClient,
            dataSource: dataSource,
            router: router
        )
    }
    
    fileprivate struct SUT {
        let interactor: CharacterListInteractorProtocolMock
        let presenter: CharacterListPresenterProtocolMock
        let viewController: CharacterListViewController
        let networkClient: NetworkClientProtocolMock
        let dataSource: CharacterListDataSource
        let router: CharacterListRouterProtocolMock
    }
}

