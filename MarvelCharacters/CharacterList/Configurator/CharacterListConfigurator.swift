//
//  CharacterListConfigurator.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation

class CharacterListConfigurator: ConfiguratorProtocol {
    typealias Parameters = Void
    typealias ViewType = CharacterListViewController
    
    func configureView(with parameters: Parameters, of type: ViewType) -> ViewType {
        let presenter = CharacterListPresenter()
        
        let interactor = CharacterListInteractor(presenter: presenter, networkClient: NetworkClient.shared)
        
        let viewController = CharacterListViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
