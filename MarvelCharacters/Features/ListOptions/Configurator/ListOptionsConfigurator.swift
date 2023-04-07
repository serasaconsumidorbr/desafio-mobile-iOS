//
//  ListOptionsConfigurator.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation
import UIKit

class ListOptionsConfigurator: ConfiguratorProtocol {
    typealias Parameters = CharacterListReloadDelegate?
    
    static func configureView(with parameters: Parameters) -> UIViewController {
        let presenter = ListOptionsPresenter()
        
        let interactor = ListOptionsInteractor(presenter: presenter, persistence: Persistence.shared)
        
        interactor.reloadDelegate = parameters
        
        let viewController = ListOptionsViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
