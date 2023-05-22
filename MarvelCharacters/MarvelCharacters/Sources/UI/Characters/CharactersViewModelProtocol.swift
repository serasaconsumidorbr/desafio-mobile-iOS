//
//  CharactersViewModelProtocol.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

import RxSwift

protocol CharactersViewModelProtocol {
    
    // MARK: - PROPERTIES
    
    var isPaginating: Bool { get set }
    var viewState: BehaviorSubject<CharactersViewState> { get }
    
    // MARK: - FUNCTIONS
    
    func retrieveCharacters(asPagination: Bool)
    func getCharacters() -> [CharacterModel]?
    func getCharacter(at index: Int) -> CharacterModel?
}
