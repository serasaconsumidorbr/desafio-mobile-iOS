//
//  CharacterListDataSourceTests.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 05/04/23.
//

import Nimble
import XCTest
@testable import MarvelCharacters

final class CharacterListDataSourceTests: XCTestCase {
    
    func testUpdatingPaginating() {
        let sut = makeSut()
        
        sut.dataSource.updating(with: .listMockPageOne, shouldPaginate: true)
        
        expect(sut.dataSource).to(equal(.mockOnePage))
        
        sut.dataSource.updating(with: .listMockPageTwo, shouldPaginate: true)
        
        expect(sut.dataSource).to(equal(.mockTwoPages))
        
        sut.dataSource.updating(with: .listMockPageThree, shouldPaginate: true)
        
        expect(sut.dataSource).to(equal(.mockThreePages))
        
        sut.dataSource.updating(with: .listMockPageFour, shouldPaginate: true)
        
        expect(sut.dataSource).to(equal(.mockFourPages))
    }
    
    func testUpdatingNotPaginating() {
        let sut = makeSut()
        
        sut.dataSource.updating(with: .listMockPageOne, shouldPaginate: true)
        
        expect(sut.dataSource).to(equal(.mockOnePage))
        
        sut.dataSource.updating(with: .listMockPageTwo, shouldPaginate: true)
        
        expect(sut.dataSource).to(equal(.mockTwoPages))
        
        sut.dataSource.updating(with: .listMockPageOne, shouldPaginate: false)
        
        expect(sut.dataSource).to(equal(.mockOnePage))
    }
    
    func testUpdatingSinglePage() {
        let sut = makeSut()
        
        sut.dataSource.updating(with: .listMockSinglePage, shouldPaginate: true)
        
        expect(sut.dataSource).to(equal(.mockFourPages))
    }
    
    func testTableViewDataSourceDelegate() {
        let sut = makeSut()
        let mockTableView = UITableView()
        mockTableView.delegate = sut.dataSource
        mockTableView.dataSource = sut.dataSource
        
        mockTableView.register(CarousellTableViewCell.self, forCellReuseIdentifier: "CarousellTableViewCell")
        mockTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
        mockTableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: "LoadingTableViewCell")
        
        sut.dataSource.updating(with: .listMockPageOne, shouldPaginate: true)
        
        sut.dataSource.updating(with: .listMockPageTwo, shouldPaginate: true)
        
        sut.dataSource.updating(with: .listMockPageThree, shouldPaginate: true)
        
        expect(sut.dataSource.numberOfSections(in: mockTableView))
            .to(equal(1))
        
        expect(sut.dataSource.tableView(mockTableView, numberOfRowsInSection: 0))
            .to(equal(3))
        
        expect(sut.dataSource.tableView(mockTableView, cellForRowAt: IndexPath(row: 0, section: 0)))
            .to(beAnInstanceOf(CarousellTableViewCell.self))
        
        expect(sut.dataSource.tableView(mockTableView, heightForRowAt: IndexPath(row: 0, section: 0)))
            .to(equal(480))
        
        expect(sut.dataSource.tableView(mockTableView, cellForRowAt: IndexPath(row: 1, section: 0)))
            .to(beAnInstanceOf(CharacterTableViewCell.self))
        
        expect(sut.dataSource.tableView(mockTableView, heightForRowAt: IndexPath(row: 1, section: 0)))
            .to(equal(118))
        
        expect(sut.dataSource.tableView(mockTableView, cellForRowAt: IndexPath(row: 2, section: 0)))
            .to(beAnInstanceOf(LoadingTableViewCell.self))
        
        expect(sut.dataSource.tableView(mockTableView, heightForRowAt: IndexPath(row: 2, section: 0)))
            .to(equal(80))
        
    }
    
    fileprivate func makeSut() -> SUT {
        let interactor = CharacterListInteractorProtocolMock()
        let dataSource = CharacterListDataSource(interactor: interactor)
        
        return SUT(
            interactor: interactor,
            dataSource: dataSource
        )
    }
    
    fileprivate struct SUT {
        let interactor: CharacterListInteractorProtocolMock
        let dataSource: CharacterListDataSource
    }
    
}
