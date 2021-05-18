//
//  MainRetrieveCharactersUseCase.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Foundation

class MainRetrieveCharactersUseCase {
    private let service: MainServiceProtocol

    init(service: MainServiceProtocol) {
        self.service = service
    }
}

extension MainRetrieveCharactersUseCase:MainRetrieveCharactersUseCaseProtocol {
    func execute(offset: Int64, completion: @escaping GenericResult<CharacterDataResponse>) {
        service.retrieveMarvelCharacters(offset: offset, completion: completion)
    }
}
