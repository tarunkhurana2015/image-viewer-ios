// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Search",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Search",
            targets: ["Search"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.2.2"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.10.0"),
        .package(url: "https://github.com/lorenzofiamingo/swiftui-cached-async-image", exact: "2.1.1"),
        .package(name: "Network", path: "../Network")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Search",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "CachedAsyncImage", package: "swiftui-cached-async-image"),
                .product(name: "Network", package: "Network")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Search"]),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Search"]),
        .testTarget(
            name: "DataTests",
            dependencies: ["Search"]),
    ]
)
