//
//  SceneDelegate.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    var dependencyInjector: DependencyInjector?
    var appCoordinator: AppCoordinator?
    var assembler: Assembler?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let navController = UINavigationController()
        navController.view.accessibilityIdentifier = "rootNav"

        setupDependencyInjector(navigationController: navController) {

            guard let windowScene = scene as? UIWindowScene else {
                return
            }
            window = UIWindow(windowScene: windowScene)
            (UIApplication.shared.delegate as? AppDelegate)?.self.window = window
            window?.windowScene = windowScene
            window?.makeKeyAndVisible()
            window?.rootViewController = navController
            appCoordinator?.start()
//            window?.rootViewController = appCoordinator?.navigationController.viewControllers.first
        }

        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func setupDependencyInjector(navigationController: UINavigationController, completion: () -> Void = {}) {
        dependencyInjector = DependencyInjector(navigationController:  navigationController)
        dependencyInjector?.build(completion: { appCoordinator, assembler in
            self.appCoordinator = appCoordinator
            self.assembler = assembler
            completion()
        })
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

