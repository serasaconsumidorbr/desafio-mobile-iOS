import AppCore
import Swinject

import Repository

public struct uCharacterList : DIHelper {
    
    static var container: Container {
        let container = Container()
        Repository.registerServicesInContainer(container: container)
        return container
    }
    
    static public func registerServicesInContainer(container: Container) {
        container.register(CharacterListViewControllerEntryPoint.self, factory: {_ in CharacterListViewControllerEntryPointImpl()})
    }
}
