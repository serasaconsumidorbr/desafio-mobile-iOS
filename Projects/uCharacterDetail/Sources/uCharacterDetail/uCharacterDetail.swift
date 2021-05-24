import AppCore
import Swinject
import Repository

public struct uCharacterDetail : DIHelper {
    
    static var container: Container {
        let container = Container()
        Repository.registerServicesInContainer(container: container)
        return container
    }
    
    static public func registerServicesInContainer(container: Container) {
        container.register(CharacterDetailViewControllerEntryPoint.self, factory: { _ in CharacterDetailViewControllerEntryPointImpl() })
    }
}
