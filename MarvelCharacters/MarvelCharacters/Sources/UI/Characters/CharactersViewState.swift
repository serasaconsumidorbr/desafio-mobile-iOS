//
//  CharactersViewState.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

enum CharactersViewState: Equatable {
    case loading(asPagination: Bool)
    case success(asPagination: Bool)
    case error(_ error: Error)

    static func == (lhs: CharactersViewState, rhs: CharactersViewState) -> Bool {
        switch (lhs, rhs) {
        case let (.loading(asPagination: lhsPagination), .loading(asPagination: rhsPagination)):
            return lhsPagination == rhsPagination
        case let (.success(asPagination: lhsPagination), .success(asPagination: rhsPagination)):
            return lhsPagination == rhsPagination
        case let (.error(lhsError), .error(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
