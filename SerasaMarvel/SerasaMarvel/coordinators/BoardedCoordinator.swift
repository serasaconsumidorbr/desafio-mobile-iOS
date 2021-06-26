//
//  BoardedCoordinator.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import UIKit

protocol BoardedCoordinatorDelegate: class {
    
}

class BoardedCoordinator: Coordinator {
    
    weak var delegate: BoardedCoordinatorDelegate?
    var childCoordinator = [String:Coordinator]()
    var window: UIWindow
    var schedulingsNavController: UINavigationController?
    var schedulerNavController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let vc = AppViewController(nibName: nil, bundle: nil)
//        vc.viewModel = BoardingViewModel()
        window.rootViewController = vc
    }
    
    func segueToSchedulingDetail(scheduling : String) {
        
    }
    
}

