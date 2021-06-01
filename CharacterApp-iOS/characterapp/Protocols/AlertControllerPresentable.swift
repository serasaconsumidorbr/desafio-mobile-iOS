//
//  AlertControllerPresentable.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import Foundation
import UIKit

protocol AlertControllerPresentable: class {
    func presentAlertController(alertController: @escaping (() -> UIAlertController))
    func presentAlertController(title: String, message: String, retry: (() -> Void)?)
}

extension AlertControllerPresentable {
    
    func presentAlertController(alertController: @escaping (() -> UIAlertController)) {
        
        DispatchQueue.main.async {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            guard let window = appDelegate.window else {
                return
            }
            
            guard let viewController = window.rootViewController?.presentedViewController ?? window.rootViewController, ((viewController as? UIAlertController) == nil)
                else {
                    return
            }
            
            viewController.present(alertController(), animated: true, completion: nil)
        }
    }
    
    
    func presentAlertController(title: String, message: String, retry: (() -> Void)?) {
        
        presentAlertController { () -> UIAlertController in
            
            let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            if let retry = retry {
                alertViewController.addAction(UIAlertAction(title: "Try again", style: .default, handler: { _ in
                    retry()
                }))
            }
            
            return alertViewController
            
        }
    }
    
}
