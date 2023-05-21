//
//  CharactersViewState.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

enum CharactersViewState {
    case loading(asPagination: Bool)
    case success(asPagination: Bool)
    case error(_ error: Error)
}
