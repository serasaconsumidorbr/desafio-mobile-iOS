//
//  AppCoordinator.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import Foundation

class AppCoordinator: Coordinator {
    
    private lazy var catalogCoordinator: CatalogCoordinator = {
        let coordinator = CatalogCoordinator()
        return coordinator
    }()
    
    override init() {
        super.init()
        super.viewController = catalogCoordinator.rootViewController
    }
    
    func start() {
        catalogCoordinator.start()
    }
    
    func stop() {
        
    }
}
