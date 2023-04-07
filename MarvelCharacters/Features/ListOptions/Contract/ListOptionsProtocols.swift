//
//  ListOptionsProtocols.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation

public protocol ListOptionsViewControllerProtocol: AnyObject {
    func updateOptions(_ listOptions: ListOptions)
}

public protocol ListOptionsInteractorProtocol: AnyObject {
    func loadOptions()
    func saveOptions(_ listOptions: ListOptions)
}

public protocol ListOptionsPresenterProtocol: AnyObject {
    var viewController: ListOptionsViewControllerProtocol? { get set }
    
    func didLoadOptions(_ listOptions: ListOptions)
}
