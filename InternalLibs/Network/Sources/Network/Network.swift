import Swinject
import AppCore

struct Network: DIHelper {
    
    static let ServerUri = ""
    
    
    static func registerServicesInContainer(container: Container) {
        container.register(CharacterService.self, factory: { _ in CharacterServiceImpl() })
    }

}
