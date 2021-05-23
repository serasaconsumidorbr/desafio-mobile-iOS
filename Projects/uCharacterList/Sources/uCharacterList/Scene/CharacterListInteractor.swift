//
//  CharacterListInteractor.swift
//  App
//
//  Created by Lucas Paim on 23/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit
import Network

protocol CharacterListBusinessLogic {
    func fetchCharacterPage(request: CharacterList.CharacterPage.Request)
}

protocol CharacterListDataStore {

}

final class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore {

    // Var's
    var presenter: CharacterListPresentationLogic?
    var worker: CharacterListWorkerLogic?

    func fetchCharacterPage(request: CharacterList.CharacterPage.Request) {
        worker?.fetchPage(parameters: CharacterListParameters(nameStartsWith: request.search, offset: request.offset))?
            .done { [weak self] response in
                let presenterResponse = CharacterList.CharacterPage.Response.Success(
                    characters: response.results,
                    hasNextPage: response.count + response.offset < response.total,
                    isFirstPage: request.offset == 0
                )
                self?.presenter?.presentCharacterPage(response: presenterResponse)
            }.catch { [weak self] error in
                let presenterResponse = CharacterList.CharacterPage.Response.Failure(error: error)
                self?.presenter?.presentCharacterPage(response: presenterResponse)
            }
    }
    
}
