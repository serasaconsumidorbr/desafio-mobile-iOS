//
//  ListOptionsPresenter.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation

class ListOptionsPresenter: ListOptionsPresenterProtocol {
    weak var viewController: ListOptionsViewControllerProtocol?
    
    func didLoadOptions(_ listOptions: ListOptions) {
        viewController?.updateOptions(listOptions)
    }
}
