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
        
        let interactor = CharacterListInteractor(presenter: presenter, networkClient: NetworkClient.shared)
        
        let viewController = CharacterListViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
