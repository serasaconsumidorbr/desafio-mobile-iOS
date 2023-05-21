//
//  ViewController.swift
//  MarvelApp
//
//  Created by Rossana Rocha on 20/05/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    
    // MARK: - Life Cycle
    override func loadView() {
        self.view = homeView
    }
}
