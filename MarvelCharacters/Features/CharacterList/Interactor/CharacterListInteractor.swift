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
    let persistence: PersistenceProtocol
    
    var offset = 0
    var count = 0
    
    var isLoading = false
    
    var listOptions: ListOptions {
        return persistence.load(ListOptions.self)
    }
    
    init(
        presenter: CharacterListPresenterProtocol,
        networkClient: NetworkClientProtocol,
        persistence: PersistenceProtocol
    ) {
        self.presenter = presenter
        self.networkClient = networkClient
        self.persistence = persistence
    }
    
    func loadCharactersPage() {
        loadCharacters(shouldPaginate: true)
    }
    
    func reloadCharacters() {
        offset = 0
        count = 0
        loadCharacters(shouldPaginate: false)
        presenter.startLoading()
    }
    
    private func loadCharacters(shouldPaginate: Bool) {
        guard !isLoading else {
            return
        }
        isLoading = true
        
        let endpoint = CharacterEndpoint.list(
            offset: offset + count,
            limit: listOptions.itemsPerPage,
            order: listOptions.listOrder.rawValue
        )
        networkClient.makeRequest(to: endpoint, of: CharacterList.self) { [weak self] result in
            switch result {
            case let .success(characterList):
                self?.offset = characterList.offset
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
