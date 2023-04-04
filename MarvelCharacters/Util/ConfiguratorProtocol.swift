//
//  ConfiguratorProtocol.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation

protocol ConfiguratorProtocol {
    associatedtype Parameters
    associatedtype ViewType
    
    func configureView(with parameters: Parameters, of type: ViewType) -> ViewType
}
