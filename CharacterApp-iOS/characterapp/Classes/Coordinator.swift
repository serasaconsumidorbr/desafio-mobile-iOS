//
//  Coordinator.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import UIKit

class Coordinator: Coordinatable {
    var childCoordinators = [Coordinatable]()
    var viewController = UIViewController()
}

extension Coordinator: AlertControllerPresentable {
    
}

extension Coordinatable where Self: Coordinator {
    
    var rootViewController: UIViewController {
        return viewController
    }
    
    func start() {
        fatalError("Implement in child")
    }
    
    func stop() {
        fatalError("Implement in child")
    }
}
