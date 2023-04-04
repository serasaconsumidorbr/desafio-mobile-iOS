//
//  ConfiguratorProtocol.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation
import UIKit

protocol ConfiguratorProtocol {
    associatedtype Parameters
    
    static func configureView(with parameters: Parameters) -> UIViewController
}
