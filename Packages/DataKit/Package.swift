// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "DataKit",
            targets: ["DataKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dmytro-anokhin/core-data-model-description", from: "0.0.11"),
    ],
    targets: [
        .target(
            name: "DataKit",
            dependencies: [
                .product(name: "CoreDataModelDescription", package: "core-data-model-description")
            ]
        ),
        .testTarget(
            name: "DataKitTests",
            dependencies: ["DataKit"]
        ),
    ]
)
