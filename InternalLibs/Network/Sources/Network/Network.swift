import Swinject
import AppCore

public struct Network: DIHelper {
    
    static let ServerUri = "http://gateway.marvel.com"
    
    static var container: Container = {
        let container = Container()
        AppCore.registerServicesInContainer(container: container)
        return container
    }()
    
    public static func registerServicesInContainer(container: Container) {
        container.register(CharacterService.self, factory: { _ in CharacterServiceImpl() })
    }

}
