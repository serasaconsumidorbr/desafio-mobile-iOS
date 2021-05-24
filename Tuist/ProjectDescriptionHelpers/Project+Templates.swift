import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    public static var organizationName: String { "com.example.marvel" }
}

public enum uFeatureTarget {
    case framework
    case testing
}

extension Target {
    public static func makeAppTargets(name: String,
                                      dependencies: [ProjectDescription.TargetDependency] = [],
                                      testDependencies: [ProjectDescription.TargetDependency] = []) -> [Target] {
        let appConfigurations: [CustomConfiguration] = [
            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Application.xcconfig")),
            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Application.xcconfig")),
        ]
        let testsConfigurations: [CustomConfiguration] = [
            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")),
            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")),
        ]
        let targetDependencies: [TargetDependency] = dependencies
        
        return [
            Target(name: name,
                   platform: .iOS,
                   product: .app,
                   bundleId: "\(Project.organizationName).\(name)",
                   deploymentTarget: .iOS(targetVersion: "12.1", devices: .iphone),
                   infoPlist: .extendingDefault(with: [
                    "UILaunchStoryboardName": "LaunchScreen",
                    "CFBundleDisplayName": "Marvel App",
                    "CFBundleName": "Marvel App",
                    "UIViewControllerBasedStatusBarAppearance": false,
                    "UIStatusBarStyle": "UIStatusBarStyleLightContent",
                    "MarvelPublicKey": "$(MARVEL_API_PUBLIC_KEY)",
                    "MarvelPrivateKey": "$(MARVEL_API_PRIVATE_KEY)",
                    "NSAppTransportSecurity": [
                        "NSAllowsArbitraryLoads": true
                    ]
                   ]),
                   sources: ["Projects/\(name)/Sources/**/*.swift"],
                   resources: ["Projects/\(name)/Resources/**/*"],
                   dependencies: targetDependencies,
                   settings: Settings(
                    configurations: appConfigurations
                   )
                ),
            Target(name: "\(name)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: "\(Project.organizationName).\(name)Tests",
                deploymentTarget: .iOS(targetVersion: "12.1", devices: .iphone),
                infoPlist: .default,
                sources: ["Projects/\(name)/Tests/**/*.swift"],
                dependencies: [
                    .target(name: name),
                    .xctest,
                ] + testDependencies,
                settings: Settings(configurations: testsConfigurations)),
        ]
    }
    
    public static func makeFrameworkTargets(name: String,
                                            dependencies: [ProjectDescription.TargetDependency] = [],
                                            testDependencies: [ProjectDescription.TargetDependency] = [],
                                            targets: Set<uFeatureTarget> = Set([.framework, .testing]),
                                            sdks: [String] = [],
                                            dependsOnXCTest: Bool = false,
                                            hasResources: Bool = false) -> [Target] {
        // Configurations
        let frameworkConfigurations: [CustomConfiguration] = [
            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Framework.xcconfig")),
            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Framework.xcconfig")),
        ]
        let testsConfigurations: [CustomConfiguration] = [
            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")),
            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")),
        ]
        
        let testFrameworkConfig: [CustomConfiguration] = [
            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-TestFramework.xcconfig")),
            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-TestFramework.xcconfig")),
        ]
        
        // Test dependencies
        var targetTestDependencies: [TargetDependency] = [
            .target(name: "\(name)"),
            .xctest,
            ] + testDependencies
        dependencies.forEach {
            if case ProjectDescription.TargetDependency.target(let uName) = $0 {
                targetTestDependencies.append(.target(name: "\(uName)Testing"))
            }
        }
        
        // Target dependencies
        var targetDependencies: [TargetDependency] = dependencies
        targetDependencies.append(contentsOf: sdks.map { .sdk(name: $0) })
        if dependsOnXCTest {
            targetDependencies.append(.xctest)
        }
        
        // Targets
        var projectTargets: [Target] = []
        if targets.contains(.framework) {
            projectTargets.append(
                Target(name: name,
                       platform: .iOS,
                       product: .framework,
                       bundleId: "\(Project.organizationName).\(name)",
                       deploymentTarget: .iOS(targetVersion: "12.1", devices: .iphone),
                       infoPlist: .default,
                       sources: ["Projects/\(name)/Sources/**/*.swift"],
                       resources: hasResources ? ["Projects/\(name)/Resources/**/*"] : nil,
                       dependencies: targetDependencies,
                       settings: Settings(configurations:
                        dependsOnXCTest ? testFrameworkConfig : frameworkConfigurations
                       )
                )
            )
        }
        if targets.contains(.testing) {
            projectTargets.append(Target(name: "\(name)Testing",
                platform: .iOS,
                product: .framework,
                bundleId: "\(Project.organizationName).\(name)Testing",
                deploymentTarget: .iOS(targetVersion: "12.1", devices: .iphone),
                infoPlist: .default,
                sources: ["Projects/\(name)/Testing/**/*.swift"],
                dependencies: [.target(name: "\(name)"), .xctest],
                settings: Settings(configurations: frameworkConfigurations)))
        }
        return projectTargets
    }
}
