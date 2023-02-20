// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PrepDataTypes",
    platforms: [
        .iOS(.v16),
        .macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PrepDataTypes",
            targets: ["PrepDataTypes"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pxlshpr/SwiftSugar", from: "0.0.86"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PrepDataTypes",
            dependencies: [
                .product(name: "SwiftSugar", package: "swiftsugar"),
            ]),
        .testTarget(
            name: "PrepDataTypesTests",
            dependencies: ["PrepDataTypes"]),
    ]
)
