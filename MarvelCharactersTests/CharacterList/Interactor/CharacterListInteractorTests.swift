//
//  CharacterListInteractorTests.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Alamofire
import Nimble
import OHHTTPStubs
import XCTest
@testable import MarvelCharacters

final class CharacterListInteractorTests: XCTestCase {
    
    override func tearDownWithError() throws {
        HTTPStubs.removeAllStubs()
    }
    
    func testLoadNextPageSuccess() {
        let sut = makeSut()
        
        stub(condition: isPath("/v1/public/characters")) { _ in
            let stubPath = OHPathForFile("v1_public_characters_list_page_one.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        sut.interactor.loadNextPage()
        
        expect(sut.interactor.isLoading)
            .toEventually(beTrue())
        
        expect(sut.presenter.calledMethods)
            .toEventually(
                equal([
                    .startLoading,
                    .didLoadSuccessfully(characterList: .listMockPageOne),
                    .stopLoading
                ])
            )
        
        expect(sut.interactor.characterList)
            .toEventually(equal(.listMockPageOne))
        
        expect(sut.interactor.isLoading)
            .toEventually(beFalse())
        
        expect(sut.networkClient.calledMethods)
            .toEventually(
                equal([
                    .makeRequest(endpoint: CharacterEndpoint.list(offset: 0, limit: 20))
                ])
            )
    }
    
    func testLoadTwoPagesSuccess() {
        let sut = makeSut()
        
        stub(condition: isPath("/v1/public/characters")) { _ in
            let stubPath = OHPathForFile("v1_public_characters_list_page_one.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        sut.interactor.loadNextPage()
        
        expect(sut.interactor.isLoading)
            .toEventually(beTrue())
        
        expect(sut.presenter.calledMethods)
            .toEventually(
                equal([
                    .startLoading,
                    .didLoadSuccessfully(characterList: .listMockPageOne),
                    .stopLoading
                ])
            )
        
        expect(sut.interactor.characterList)
            .toEventually(equal(.listMockPageOne))
        
        expect(sut.interactor.isLoading)
            .toEventually(beFalse())
        
        expect(sut.networkClient.calledMethods)
            .toEventually(
                equal([
                    .makeRequest(endpoint: CharacterEndpoint.list(offset: 0, limit: 20))
                ])
            )
        
        stub(condition: isPath("/v1/public/characters")) { _ in
            let stubPath = OHPathForFile("v1_public_characters_list_page_two.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        sut.interactor.loadNextPage()
        
        expect(sut.interactor.isLoading)
            .toEventually(beTrue())
        
        expect(sut.presenter.calledMethods)
            .toEventually(
                equal([
                    .startLoading,
                    .didLoadSuccessfully(characterList: .listMockPageOne),
                    .stopLoading,
                    .startLoading,
                    .didLoadSuccessfully(characterList: .listMockPageTwo),
                    .stopLoading
                ])
            )
        
        expect(sut.interactor.characterList)
            .toEventually(equal(.listMockPageOneAndTwo))
        
        expect(sut.interactor.isLoading)
            .toEventually(beFalse())
        
        expect(sut.networkClient.calledMethods)
            .toEventually(
                equal([
                    .makeRequest(endpoint: CharacterEndpoint.list(offset: 0, limit: 20)),
                    .makeRequest(endpoint: CharacterEndpoint.list(offset: 2, limit: 2))
                ])
            )
    }
    
    fileprivate func makeSut() -> SUT {
        let presenter = CharacterListPresenterProtocolMock()
        let networkClient = NetworkClientProtocolMock()
        let interactor = CharacterListInteractor(presenter: presenter, networkClient: networkClient)
        let viewController = CharacterListViewControllerProtocolMock()
        
        return SUT(interactor: interactor, presenter: presenter, viewController: viewController, networkClient: networkClient)
    }
    
    fileprivate struct SUT {
        let interactor: CharacterListInteractor
        let presenter: CharacterListPresenterProtocolMock
        let viewController: CharacterListViewControllerProtocolMock
        let networkClient: NetworkClientProtocolMock
    }
}


