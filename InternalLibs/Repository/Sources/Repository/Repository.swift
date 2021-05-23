import Swinject

// MARK: - Create a Generalized existentials to make DI possible
// https://github.com/apple/swift/blob/main/docs/GenericsManifesto.md#generalized-existentials
fileprivate typealias CharacterDatabase = RealmDatabase<DBCharacter>

public struct Repository {
    static var internalContainer: Container = {
        let container = Container()
        container.register(CharacterDatabase.self, factory: { _ in RealmDatabase() })
        return container
    }()
    
    public static var container: Container = {
        let container = Container()
        return container
    }()
}
