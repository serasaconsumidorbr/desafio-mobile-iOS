//
//  AppCoordinator.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import UIKit

import UIKit

class AppCoordinator : Coordinator {
    
    // Evitar conflito de referência do mesmo nome
    fileprivate let APP_KEY: String  = "app"
    
    var childCoordinator = [String:Coordinator]()
    
    var window : UIWindow
    
    init(window : UIWindow) {
        self.window = window
    }
    
    func start() { showBoarded() }
    
}

extension AppCoordinator : BoardedCoordinatorDelegate {
    
    func showBoarded() {
        let boardCoordinator = BoardedCoordinator(window: window)
        childCoordinator[APP_KEY] = boardCoordinator
        boardCoordinator.delegate = self
        boardCoordinator.start()
    }
    
}
