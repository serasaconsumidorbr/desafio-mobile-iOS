//
//  CharacterViewController.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation

import UIKit

class CharacterViewController: UIViewController {
    // MARK: - Properts
    var charactersViewModel = CharacterViewModel() {
        didSet {
            characterView.setData(viewModel: self.charactersViewModel)
        }
    }
    
    private lazy var characterView: CharacterView = {
        let view = CharacterView()
        view.backgroundColor = .white
        
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        self.view = characterView
    }
}
