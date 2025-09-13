// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MMExpressionSolver",
    defaultLocalization: "en",
    platforms: [.iOS(.v18), .macOS(.v15), .watchOS(.v11), .tvOS(.v18), .visionOS(.v2)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MMExpressionSolver",
            targets: ["MMExpressionSolver"]),
    ],
    dependencies: [
        .package(url: "https://github.com/MarcusMiss/MMEcletic.git", .upToNextMajor(from: "1.3.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MMExpressionSolver",
            dependencies: [
                .product(name: "MMEcletic", package: "MMEcletic"),
            ]
        ),
        .testTarget(
            name: "MMExpressionSolverTests",
            dependencies: [
                "MMExpressionSolver",
                .product(name: "MMEcletic", package: "MMEcletic")
            ]
        ),
    ]
)
