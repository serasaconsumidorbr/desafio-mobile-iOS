import Swinject

public struct AppCore: DIHelper {
    public static func registerServicesInContainer(container: Container) {
        container.register(Loggable.self, factory: { _ in Logger() })
    }
}
