// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftAST",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftAST",
            targets: ["SwiftAST"]),
        .executable(name: "swift-ast",
                    targets: ["swift-ast"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftAST",
            dependencies: ["Base", "Parser"]),
        .target(
            name: "Parser",
            dependencies: ["Base"]),
        .target(
            name: "swift-ast",
            dependencies: ["Parser"]),
        .target(
            name: "Base",
            dependencies: []),
        .testTarget(
            name: "SwiftASTTests",
            dependencies: ["SwiftAST"]),
    ]
)
