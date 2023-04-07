//
//  ViewControllerMock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 07/04/23.
//

import Foundation
import UIKit

class ViewControllerMock: UIViewController {
    var calledMethods: [Methods] = []
    
    enum Methods: Equatable {
        case present(viewController: UIViewController, animated: Bool)
    }
    
    override func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil
    ) {
        calledMethods.append(.present(viewController: viewControllerToPresent, animated: flag))
    }
}
