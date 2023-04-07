//
//  ListOptionsInteractor.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation

class ListOptionsInteractor: ListOptionsInteractorProtocol {
    let presenter: ListOptionsPresenterProtocol
    let persistence: PersistenceProtocol
    
    weak var reloadDelegate: CharacterListReloadDelegate?
    
    init(presenter: ListOptionsPresenterProtocol, persistence: PersistenceProtocol) {
        self.presenter = presenter
        self.persistence = persistence
    }
    
    func loadOptions() {
        let options = persistence.load(ListOptions.self)
        presenter.didLoadOptions(options)
    }
    
    func saveOptions(_ listOptions: ListOptions) {
        persistence.save(listOptions)
        persistence.sync()
        reloadDelegate?.reloadCharacters()
    }
}
