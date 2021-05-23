import UIKit
import AppColors

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
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
