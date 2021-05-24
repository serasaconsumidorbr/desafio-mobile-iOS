// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppCoreUI",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AppCoreUI",
            targets: ["AppCoreUI"]),
    ],
    dependencies: [
        .package(path: "../AppCore"),
        .package(path: "../Carousel"),
        .package(path: "../InfiniteScrolling"),
        .package(path: "../AppColors"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AppCoreUI",
            dependencies: [
                "AppCore", "Carousel",
                "InfiniteScrolling", "AppColors"
            ]),
        .testTarget(
            name: "AppCoreUITests",
            dependencies: ["AppCoreUI"]),
    ]
)
