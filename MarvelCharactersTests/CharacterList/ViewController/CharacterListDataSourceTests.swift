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
        var sut = makeSut()
        
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
        var sut = makeSut()
        
        sut.dataSource.updating(with: .listMockPageOne, shouldPaginate: true)
        
        expect(sut.dataSource).to(equal(.mockOnePage))
        
        sut.dataSource.updating(with: .listMockPageTwo, shouldPaginate: true)
        
        expect(sut.dataSource).to(equal(.mockTwoPages))
        
        sut.dataSource.updating(with: .listMockPageOne, shouldPaginate: false)
        
        expect(sut.dataSource).to(equal(.mockOnePage))
    }
    
    func testUpdatingSinglePage() {
        var sut = makeSut()
        
        sut.dataSource.updating(with: .listMockSinglePage, shouldPaginate: true)
        
        expect(sut.dataSource).to(equal(.mockFourPages))
    }
    
    fileprivate func makeSut() -> SUT {
        let dataSource = CharacterListDataSource()
                
        return SUT(
            dataSource: dataSource
        )
    }
    
    fileprivate struct SUT {
        var dataSource: CharacterListDataSource
    }
}


