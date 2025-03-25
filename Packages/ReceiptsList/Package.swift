// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReceiptsList",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "ReceiptsList",
            targets: ["ReceiptsList"]),
    ],
    dependencies: [
        .package(path: "../DataKit"),
    ],
    targets: [
        .target(
            name: "ReceiptsList",
            dependencies: [
                .product(name: "DataKit", package: "DataKit")
            ]
        ),
        .testTarget(
            name: "ReceiptsListTests",
            dependencies: ["ReceiptsList"]
        ),
    ]
)
