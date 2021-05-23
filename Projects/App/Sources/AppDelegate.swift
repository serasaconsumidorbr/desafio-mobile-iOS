import UIKit
import Swinject
import AppColors

import AppCore
import Network
import Repository


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

        
        let networkTest = container.resolve(CharacterRepository.self)
        networkTest?.fetchCharacterList(parameters: CharacterListParameters()).done {
            debugPrint($0)
        }.catch {
            debugPrint($0)
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: Entrypoint())
        window?.makeKeyAndVisible()
        return true
    }
}


//MARK: - Temporary Entrypoint

class Entrypoint: UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = .secondaryBackgroundColor
    }
}
