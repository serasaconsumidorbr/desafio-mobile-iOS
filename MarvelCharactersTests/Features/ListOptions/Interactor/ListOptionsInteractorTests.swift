//
//  ListOptionsInteractorTests.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Nimble
import XCTest
@testable import MarvelCharacters

final class ListOptionsInteractorTests: XCTestCase {
    
    func testLoadOptions() {
        let sut = makeSut()
        
        sut.interactor.loadOptions()
        
        expect(sut.persistence.calledMethods)
            .to(
                equal([
                    .loadPersistable
                ])
            )
        
        expect(sut.presenter.calledMethods)
            .to(
                equal([
                    .didLoadOptions(listOptions: ListOptions.defaultValue)
                ])
            )
        
        expect(sut.reloadDelegate.calledMethods)
            .to(beEmpty())
    }
    
    func testSaveOptions() {
        let sut = makeSut()
        
        sut.interactor.saveOptions(ListOptions(listOrder: .nameIncreasing, itemsPerPage: 66))
        
        expect(sut.persistence.calledMethods)
            .to(
                equal([
                    .savePersistable,
                    .sync
                ])
            )
        
        expect(sut.reloadDelegate.calledMethods)
            .to(
                equal([
                    .reloadCharacters
                ])
            )
    }
    
    fileprivate func makeSut() -> SUT {
        let presenter = ListOptionsPresenterProtocolMock()
        let persistence = PersistenceProtocolMock()
        let interactor = ListOptionsInteractor(
            presenter: presenter,
            persistence: persistence
        )
        
        let reloadDelegate = CharacterListInteractorProtocolMock()
        
        interactor.reloadDelegate = reloadDelegate
        
        let viewController = ListOptionsViewControllerProtocolMock()
        
        return SUT(
            interactor: interactor,
            presenter: presenter,
            viewController: viewController,
            persistence: persistence,
            reloadDelegate: reloadDelegate
        )
    }
    
    fileprivate struct SUT {
        let interactor: ListOptionsInteractor
        let presenter: ListOptionsPresenterProtocolMock
        let viewController: ListOptionsViewControllerProtocolMock
        let persistence: PersistenceProtocolMock
        let reloadDelegate: CharacterListInteractorProtocolMock
    }
}
