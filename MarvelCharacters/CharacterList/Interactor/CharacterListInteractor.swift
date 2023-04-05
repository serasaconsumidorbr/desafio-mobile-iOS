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
        if !isLoading {
            isLoading = true
            presenter.startLoading()
            
            let endpoint = CharacterEndpoint.list(
                offset: offset + count,
                limit: limit
            )
            networkClient.makeRequest(to: endpoint, of: CharacterList.self) { [weak self] result in
                switch result {
                case let .success(characterList):
                    self?.presenter.didLoadSuccessfully(characterList, shouldPaginate: shouldPaginate)
                case let .failure(error):
                    self?.presenter.didFailLoading(error)
                }
                self?.isLoading = false
                self?.presenter.stopLoading()
            }
        }
    }
}
