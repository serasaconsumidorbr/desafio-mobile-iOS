
import Swinject
import AppCore
import Network

// MARK: - Create a Generalized existentials to make DI possible
// https://github.com/apple/swift/blob/main/docs/GenericsManifesto.md#generalized-existentials
typealias CharacterDatabase = RealmDatabase<DBCharacter>

public struct Repository: DIHelper {
    static var container: Container = {
        let container = Container()
        container.register(CharacterDatabase.self, factory: { _ in RealmDatabase() })
        Network.registerServicesInContainer(container: container)
        return container
    }()
    
    public static func registerServicesInContainer(container externalContainer: Container) {
        externalContainer.register(CharacterRepository.self, factory: { _ in
                            CharacterRepositoryImpl(
                                characterService: container.resolve(CharacterService.self),
                                characterDatabase: container.resolve(CharacterDatabase.self)
                            )
            
        })
    }
    
}
