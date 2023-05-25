//
//  ViewController.swift
//  MarvelApp
//
//  Created by Rossana Rocha on 20/05/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var homeView = HomeView(viewModel: homeViewModel)
    
    private var homeViewModel = HomeViewModel()
    
    // MARK: - Life Cycle
    override func loadView() {
        self.view = homeView
    }
}
