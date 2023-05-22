//
//  SceneDelegate.swift
//  MarvelCharacters
//
//  Created by iris on 19/05/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let controller = CharactersViewController(viewModel: CharactersViewModel(charactersUseCase: CharactersUseCase(networking: NetworkingOperation())))
        window = UIWindow(frame: .zero)
        window?.makeKeyAndVisible()
        window?.rootViewController = controller
        window?.windowScene = windowScene
    }
}

