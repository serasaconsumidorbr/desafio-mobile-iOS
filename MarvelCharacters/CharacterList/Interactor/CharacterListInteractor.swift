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
    
    var characterList: CharacterList = CharacterList(
        copyright: "",
        offset: 0,
        limit: 20,
        total: 0,
        count: 0,
        characters: []
    )
    var isLoading = false
    
    init(presenter: CharacterListPresenterProtocol, networkClient: NetworkClientProtocol) {
        self.presenter = presenter
        self.networkClient = networkClient
    }
    
    func loadNextPage() {
        if !isLoading {
            isLoading = true
            presenter.startLoading()
            let endpoint = CharacterEndpoint.list(
                offset: characterList.offset + characterList.count,
                limit: characterList.limit
            )
            networkClient.makeRequest(to: endpoint, of: CharacterList.self) { [weak self] result in
                switch result {
                case let .success(characterList):
                    self?.characterList.updating(with: characterList)
                    self?.presenter.didLoadSuccessfully(characterList)
                case let .failure(error):
                    self?.presenter.didFailLoading(error)
                }
                self?.isLoading = false
                self?.presenter.stopLoading()
            }
        }
    }
}
