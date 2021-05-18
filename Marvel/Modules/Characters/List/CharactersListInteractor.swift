//
//  CharactersListInteractor.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CharactersListBusinessLogic {
    func fetchCharacters(request: CharacterList.FetchCharacters.Request)
}

protocol CharactersListDataStore {

}

final class CharactersListInteractor: CharactersListBusinessLogic, CharactersListDataStore {

    // MARK: - Var's
    var presenter: CharactersListPresentationLogic?
    var worker = CharactersListWorker()
    
    // MARK: - Func's
    func fetchCharacters(request: CharacterList.FetchCharacters.Request){
        worker.fetchCharacters(offset: request.offset)
        .done { [weak self] response in
            let response = CharacterList.FetchCharacters.Response.Success(data: response)
            self?.presenter?.presentSuccessFetchCharacters(response: response)
        }.catch { [weak self] error in
            let response = CharacterList.FetchCharacters.Response.Failure(error: error)
            self?.presenter?.presentFailureFetchCharacters(response: response)
        }
    }
}
