//
//  CharacterListConfigurator.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation
import UIKit

class CharacterListConfigurator: ConfiguratorProtocol {
    typealias Parameters = Void
    
    static func configureView(with parameters: Parameters) -> UIViewController {
        let presenter = CharacterListPresenter()
        
        let interactor = CharacterListInteractor(
            presenter: presenter,
            networkClient: NetworkClient.shared,
            persistence: Persistence.shared
        )
        
        let dataSource = CharacterListDataSource(interactor: interactor)
        
        let router = CharacterListRouter()
        
        let viewController = CharacterListViewController(
            interactor: interactor,
            dataSource: dataSource,
            router: router
        )
        
        presenter.viewController = viewController
        
        router.viewController = viewController
        
        return viewController
    }
}
