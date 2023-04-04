//
//  CharacterListViewController.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation
import UIKit

class CharacterListViewController: BaseViewCodeController, CharacterListViewControllerProtocol {
    
    let interactor: CharacterListInteractorProtocol
    
    init(interactor: CharacterListInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addSubviews() {
        
    }
    
    override func setupConstraints() {
        
    }
    
    override func setupSubviews() {
        
    }
}

extension CharacterListViewControllerProtocol {
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
}
