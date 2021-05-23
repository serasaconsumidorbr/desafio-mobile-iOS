import UIKit
import Swinject
import AppColors

import AppCore
import Network
import Repository

import uCharacterList


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var container: Container = Container()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        AppCore.registerServicesInContainer(container: container)
        Network.registerServicesInContainer(container: container)
        Repository.registerServicesInContainer(container: container)
        uCharacterList.registerServicesInContainer(container: container)
        
        configureNavigationAppearence()
        
        let listEntryPoint = container.resolve(CharacterListViewControllerEntryPoint.self)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: listEntryPoint?.createCharacterListVC() ?? UIViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
    func configureNavigationAppearence() {
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = .textColor
        
        UINavigationBar.appearance().barTintColor = .secondaryBackgroundColor
        UINavigationBar.appearance().isTranslucent = false

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.secondaryBackgroundColor
            appearance.titleTextAttributes = [
                .font: UIFont.init(name: "marvel", size: 32)!,
                .foregroundColor: UIColor.textColor!
            ]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().titleTextAttributes = [
                .font: UIFont.init(name: "marvel", size: 32)!,
                .foregroundColor: UIColor.textColor!
            ]
        }
    }
}
