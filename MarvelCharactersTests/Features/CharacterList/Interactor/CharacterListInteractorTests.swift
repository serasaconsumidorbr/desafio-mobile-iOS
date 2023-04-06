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
        
        sut.interactor.loadCharacters(shouldPaginate: true)
        
        expect(sut.interactor.isLoading)
            .to(beTrue())
        
        expect(sut.presenter.calledMethods)
            .toEventually(
                equal([
                    .startLoading,
                    .didLoadSuccessfully(characterList: .listMockPageOne, shouldPaginate: true),
                    .stopLoading
                ])
            )
        
        expect(sut.interactor.count)
            .to(equal(2))
        
        expect(sut.interactor.offset)
            .to(equal(0))
        
        expect(sut.interactor.isLoading)
            .to(beFalse())
        
        expect(sut.networkClient.calledMethods)
            .toEventually(
                equal([
                    .makeRequest(endpoint: CharacterEndpoint.list(offset: 0, limit: 20, order: "name"))
                ])
            )
    }
    
    func testLoadWhileAlreadyLoading() {
        let sut = makeSut()
        
        sut.interactor.isLoading = true
        sut.interactor.loadCharacters(shouldPaginate: true)
        
        expect(sut.interactor.isLoading)
            .to(beTrue())
        
        expect(sut.presenter.calledMethods)
            .toEventually(
                equal([])
            )
        
        expect(sut.interactor.count)
            .to(equal(0))
        
        expect(sut.interactor.offset)
            .to(equal(0))
        
        expect(sut.networkClient.calledMethods)
            .toEventually(
                equal([])
            )
    }
    
    func testLoadTwoPagesSuccess() {
        let sut = makeSut()
        
        stub(condition: isPath("/v1/public/characters")) { _ in
            let stubPath = OHPathForFile("v1_public_characters_list_page_one.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        sut.interactor.loadCharacters(shouldPaginate: true)
        
        expect(sut.interactor.isLoading)
            .to(beTrue())
        
        expect(sut.presenter.calledMethods)
            .toEventually(
                equal([
                    .startLoading,
                    .didLoadSuccessfully(characterList: .listMockPageOne, shouldPaginate: true),
                    .stopLoading
                ])
            )
        
        expect(sut.interactor.count)
            .to(equal(2))
        
        expect(sut.interactor.offset)
            .to(equal(0))
        
        expect(sut.interactor.isLoading)
            .to(beFalse())
        
        expect(sut.networkClient.calledMethods)
            .toEventually(
                equal([
                    .makeRequest(endpoint: CharacterEndpoint.list(offset: 0, limit: 20, order: "name"))
                ])
            )
        
        stub(condition: isPath("/v1/public/characters")) { _ in
            let stubPath = OHPathForFile("v1_public_characters_list_page_two.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        sut.interactor.loadCharacters(shouldPaginate: true)
        
        expect(sut.interactor.isLoading)
            .to(beTrue())
        
        expect(sut.presenter.calledMethods)
            .toEventually(
                equal([
                    .startLoading,
                    .didLoadSuccessfully(characterList: .listMockPageOne, shouldPaginate: true),
                    .stopLoading,
                    .startLoading,
                    .didLoadSuccessfully(characterList: .listMockPageTwo, shouldPaginate: true),
                    .stopLoading
                ])
            )
        
        expect(sut.interactor.count)
            .to(equal(2))
        
        expect(sut.interactor.offset)
            .to(equal(2))
        
        expect(sut.interactor.isLoading)
            .to(beFalse())
        
        expect(sut.networkClient.calledMethods)
            .toEventually(
                equal([
                    .makeRequest(endpoint: CharacterEndpoint.list(offset: 0, limit: 20, order: "name")),
                    .makeRequest(endpoint: CharacterEndpoint.list(offset: 2, limit: 20, order: "name"))
                ])
            )
    }
    
    func testLoadWithoutPaginating() {
        let sut = makeSut()
        
        stub(condition: isPath("/v1/public/characters")) { _ in
            let stubPath = OHPathForFile("v1_public_characters_list_page_one.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        sut.interactor.loadCharacters(shouldPaginate: true)
        
        expect(sut.interactor.isLoading)
            .to(beTrue())
        
        expect(sut.presenter.calledMethods)
            .toEventually(
                equal([
                    .startLoading,
                    .didLoadSuccessfully(characterList: .listMockPageOne, shouldPaginate: true),
                    .stopLoading
                ])
            )
        
        expect(sut.interactor.count)
            .to(equal(2))
        
        expect(sut.interactor.offset)
            .to(equal(0))
        
        expect(sut.interactor.isLoading)
            .to(beFalse())
        
        expect(sut.networkClient.calledMethods)
            .toEventually(
                equal([
                    .makeRequest(endpoint: CharacterEndpoint.list(offset: 0, limit: 20, order: "name"))
                ])
            )
        
        stub(condition: isPath("/v1/public/characters")) { _ in
            let stubPath = OHPathForFile("v1_public_characters_list_page_two.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        sut.interactor.loadCharacters(shouldPaginate: false)
        
        expect(sut.interactor.isLoading)
            .to(beTrue())
        
        expect(sut.interactor.count)
            .to(equal(0))
        
        expect(sut.interactor.offset)
            .to(equal(0))
        
        expect(sut.presenter.calledMethods)
            .toEventually(
                equal([
                    .startLoading,
                    .didLoadSuccessfully(characterList: .listMockPageOne, shouldPaginate: true),
                    .stopLoading,
                    .startLoading,
                    .didLoadSuccessfully(characterList: .listMockPageTwo, shouldPaginate: false),
                    .stopLoading
                ])
            )
        
        expect(sut.interactor.count)
            .to(equal(2))
        
        expect(sut.interactor.offset)
            .to(equal(2))
        
        expect(sut.interactor.isLoading)
            .to(beFalse())
        
        expect(sut.networkClient.calledMethods)
            .toEventually(
                equal([
                    .makeRequest(endpoint: CharacterEndpoint.list(offset: 0, limit: 20, order: "name")),
                    .makeRequest(endpoint: CharacterEndpoint.list(offset: 0, limit: 20, order: "name"))
                ])
            )
    }
    
    fileprivate func makeSut() -> SUT {
        let presenter = CharacterListPresenterProtocolMock()
        let networkClient = NetworkClientProtocolMock()
        let persistence = PersistenceProtocolMock()
        let interactor = CharacterListInteractor(
            presenter: presenter,
            networkClient: networkClient,
            persistence: persistence
        )
        let viewController = CharacterListViewControllerProtocolMock()
        
        return SUT(
            interactor: interactor,
            presenter: presenter,
            viewController: viewController,
            networkClient: networkClient,
            persistence: persistence
        )
    }
    
    fileprivate struct SUT {
        let interactor: CharacterListInteractor
        let presenter: CharacterListPresenterProtocolMock
        let viewController: CharacterListViewControllerProtocolMock
        let networkClient: NetworkClientProtocolMock
        let persistence: PersistenceProtocolMock
    }
}
