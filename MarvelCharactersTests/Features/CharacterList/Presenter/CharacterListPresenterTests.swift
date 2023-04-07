//
//  CharacterListPresenterTests.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 05/04/23.
//

import Foundation
import Nimble
import XCTest
@testable import MarvelCharacters

final class CharacterListPresenterTests: XCTestCase {
    
    func testStartLoading() {
        let sut = makeSut()
        
        sut.presenter.startLoading()
        
        expect(sut.viewController.calledMethods)
            .to(
                equal([
                    .startLoading
                ])
            )
    }
    
    func testStopLoading() {
        let sut = makeSut()
        
        sut.presenter.stopLoading()
        
        expect(sut.viewController.calledMethods)
            .to(
                equal([
                    .stopLoading
                ])
            )
    }
    
    func testDidLoadSuccessfully() {
        let sut = makeSut()
        
        sut.presenter.didLoadSuccessfully(.listMockPageOne, shouldPaginate: true)
        
        expect(sut.viewController.calledMethods)
            .to(
                equal([
                    .updateDataSource(characterList: .listMockPageOne, shouldPaginate: true)
                ])
            )
    }
    
    func testDidFailLoading() {
        let sut = makeSut()
        
        sut.presenter.didFailLoading("Failed loading")
        
        expect(sut.viewController.calledMethods)
            .to(beEmpty())
    }
    
    fileprivate func makeSut() -> SUT {
        let presenter = CharacterListPresenter()
        let viewController = CharacterListViewControllerProtocolMock()
        
        presenter.viewController = viewController
        
        return SUT(
            presenter: presenter,
            viewController: viewController
        )
    }
    
    fileprivate struct SUT {
        let presenter: CharacterListPresenterProtocol
        let viewController: CharacterListViewControllerProtocolMock
    }
}
