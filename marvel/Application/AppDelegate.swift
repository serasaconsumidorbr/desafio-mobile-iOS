//
//  AppDelegate.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 25/07/22.
//

import UIKit

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    private(set) var applicationCoordinator: Coordinator?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navController = UINavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        applicationCoordinator = AppCoordinator(navController)
        applicationCoordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
