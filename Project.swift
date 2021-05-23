import ProjectDescription
import ProjectDescriptionHelpers


// MARK: - Target's

var allTargets: [Target] {
    Target.makeAppTargets(name: "App", dependencies: allPackages)
}

var allLocalPackages: [Package] {
    [
        .local(path: .relativeToManifest("InternalLibs/AppCoreUI")),
        .local(path: .relativeToManifest("InternalLibs/Carousel")),
        .local(path: .relativeToManifest("InternalLibs/InfiniteScrolling")),
        .local(path: .relativeToManifest("InternalLibs/AppColors")),

        .local(path: .relativeToManifest("InternalLibs/AppCore")),
        .local(path: .relativeToManifest("InternalLibs/Network")),
        .local(path: .relativeToManifest("InternalLibs/Repository")),
        
        .local(path: .relativeToManifest("InternalLibs/Repository")),

        .local(path: .relativeToManifest("Projects/uCharacterList")),
        .local(path: .relativeToManifest("Projects/uCharacterDetail")),
    ]
}

var allPackages: [TargetDependency] {
    [
        .package(product: "AppCoreUI"),
        .package(product: "Carousel"),
        .package(product: "InfiniteScrolling"),
        .package(product: "AppColors"),
        .package(product: "AppCore"),
        .package(product: "Network"),
        .package(product: "Repository"),
        
        .package(product: "uCharacterList"),
        .package(product: "uCharacterDetail")
    ]
}

// MARK: - Project
let app = Project(
    name: "App",
    organizationName: Project.organizationName,
    packages: allLocalPackages,
    targets: allTargets
)

