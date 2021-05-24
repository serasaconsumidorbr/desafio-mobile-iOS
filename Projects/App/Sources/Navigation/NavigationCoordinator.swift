//
//  NavigationCoordinator.swift
//  App
//
//  Created by Lucas Paim on 24/05/21.
//  Copyright © 2021 com.example.marvel. All rights reserved.
//

import UIKit
import Swinject
import AppCoreUI
import uCharacterList
import uCharacterDetail
import AppColors

final class NavigationCoordinator : NSObject, CharacterListNavigationDelegate, UINavigationControllerDelegate {
    func openCharacterDetail(id: Int, present: BaseViewController) {
        guard let container = (UIApplication.shared.delegate as? AppDelegate)?.container,
              let detailEntryPoint = container.resolve(CharacterDetailViewControllerEntryPoint.self) else { return }
        let detail = detailEntryPoint.createCharacterDetailVC(id: id)
        present.navigationController?.delegate = self
        present.navigationController?.pushViewController(detail, animated: true)
    }
    
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        item.tintColor = .textColor
        viewController.navigationItem.backBarButtonItem = item
    }
}
