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
        let sut = CharacterListDataSource()
        
        sut.updating(with: .listMockPageOne, shouldPaginate: true)
        
        print(sut)
        print(CharacterListDataSource.mockOnePage)
        expect(sut).to(equal(.mockOnePage))
        
        sut.updating(with: .listMockPageTwo, shouldPaginate: true)
        
        expect(sut).to(equal(.mockTwoPages))
        
        sut.updating(with: .listMockPageThree, shouldPaginate: true)
        
        expect(sut).to(equal(.mockThreePages))
        
        sut.updating(with: .listMockPageFour, shouldPaginate: true)
        
        expect(sut).to(equal(.mockFourPages))
    }
    
    func testUpdatingNotPaginating() {
        let sut = CharacterListDataSource()
        
        sut.updating(with: .listMockPageOne, shouldPaginate: true)
        
        expect(sut).to(equal(.mockOnePage))
        
        sut.updating(with: .listMockPageTwo, shouldPaginate: true)
        
        expect(sut).to(equal(.mockTwoPages))
        
        sut.updating(with: .listMockPageOne, shouldPaginate: false)
        
        expect(sut).to(equal(.mockOnePage))
    }
    
    func testUpdatingSinglePage() {
        let sut = CharacterListDataSource()
        
        sut.updating(with: .listMockSinglePage, shouldPaginate: true)
        
        expect(sut).to(equal(.mockFourPages))
    }
    
}
