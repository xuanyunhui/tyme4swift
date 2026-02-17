// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "tyme",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "tyme",
            targets: ["tyme"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.4.3"),
        .package(url: "https://github.com/google/swift-benchmark", from: "0.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "tyme"
        ),
        .testTarget(
            name: "tymeTests",
            dependencies: ["tyme"]
        ),
        .executableTarget(
            name: "TymeBenchmarks",
            dependencies: [
                "tyme",
                .product(name: "Benchmark", package: "swift-benchmark")
            ],
            path: "Benchmarks",
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
    ]
)
