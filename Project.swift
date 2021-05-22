import ProjectDescription
import ProjectDescriptionHelpers


// MARK: - Target's


let carouselTargets = Target.makeAppTargets(
    name: "CarouselApp",
    dependencies: [
        .package(product: "Carousel")
    ])

let infiniteScrollingTargets = Target.makeAppTargets(
    name: "InfiniteScrollingApp",
    dependencies: [
        .package(product: "InfiniteScrolling")
    ])

var uCharacterList = Target.makeFrameworkTargets(
    name: "uCharacterList",
    dependencies: [
        .package(product: "Network"),
        .package(product: "AppCoreUI"),
    ]
)

var uCharacterDetail = Target.makeFrameworkTargets(
    name: "uCharacterDetail",
    dependencies: [
        .package(product: "Network"),
        .package(product: "AppCoreUI"),
    ]
)

var allTargets: [Target] {
    Target.makeAppTargets(name: "App")
        + carouselTargets
        + infiniteScrollingTargets
        + uCharacterList
        + uCharacterDetail
}

var allLocalPackages: [Package] {
    [
        .local(path: .relativeToManifest("InternalLibs/AppCoreUI")),
        .local(path: .relativeToManifest("InternalLibs/Carousel")),
        .local(path: .relativeToManifest("InternalLibs/InfiniteScrolling")),
        .local(path: .relativeToManifest("InternalLibs/AppColors")),

        .local(path: .relativeToManifest("InternalLibs/AppCore")),
        .local(path: .relativeToManifest("InternalLibs/Network")),
        .local(path: .relativeToManifest("InternalLibs/Storage")),
        .local(path: .relativeToManifest("InternalLibs/Repository")),
    ]
}

// MARK: - Feature App's

//let carouselApp = Project(
//    name: "CarouselApp",
//    organizationName: Project.organizationName,
//    packages: [
//        .local(path: .relativeToManifest("InternalLibs/Carousel"))
//    ],
//    targets: carouselTargets
//)

//let infiniteScrollingApp = Project(
//    name: "InfiniteScrollingApp",
//    organizationName: Project.organizationName,
//    packages: [
//        .local(path: .relativeToManifest("InternalLibs/InfiniteScrolling"))
//    ],
//    targets: infiniteScrollingTargets
//)

// MARK: - Project


let app = Project(
    name: "App",
    organizationName: Project.organizationName,
    packages: allLocalPackages,
    targets: allTargets
)

