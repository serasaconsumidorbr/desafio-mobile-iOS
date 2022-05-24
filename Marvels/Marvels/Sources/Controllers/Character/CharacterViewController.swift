//
//  CharacterViewController.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation

import UIKit

class CharacterViewController: UIViewController {
    private lazy var characterView: CharacterView = {
        let view = CharacterView()
        self.view.backgroundColor = .systemBackground
        
        return view
    }()
    
    override func loadView() {
        super.loadView()
        self.view = characterView
    }
}
