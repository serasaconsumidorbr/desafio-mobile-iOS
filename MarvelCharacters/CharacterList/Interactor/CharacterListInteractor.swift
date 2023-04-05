//
//  CharacterListInteractor.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation

class CharacterListInteractor: CharacterListInteractorProtocol {
    let presenter: CharacterListPresenterProtocol
    let networkClient: NetworkClientProtocol
    
    var offset = 0
    var limit = 20
    var count = 0
    
    var isLoading = false
    
    init(presenter: CharacterListPresenterProtocol, networkClient: NetworkClientProtocol) {
        self.presenter = presenter
        self.networkClient = networkClient
    }
    
    func loadCharacters(shouldPaginate: Bool) {
        guard !isLoading else {
            return
        }
        isLoading = true
        presenter.startLoading()
        
        if !shouldPaginate {
            offset = 0
            limit = 20
            count = 0
        }
        
        let endpoint = CharacterEndpoint.list(
            offset: offset + count,
            limit: limit
        )
        networkClient.makeRequest(to: endpoint, of: CharacterList.self) { [weak self] result in
            switch result {
            case let .success(characterList):
                self?.offset = characterList.offset
                self?.limit = characterList.limit
                self?.count = characterList.count
                self?.presenter.didLoadSuccessfully(characterList, shouldPaginate: shouldPaginate)
            case let .failure(error):
                self?.presenter.didFailLoading(error.localizedDescription)
            }
            self?.isLoading = false
            self?.presenter.stopLoading()
        }
    }
}
