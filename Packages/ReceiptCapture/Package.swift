// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReceiptCapture",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "ReceiptCapture",
            targets: ["ReceiptCapture"]),
    ],
    dependencies: [
        .package(path: "../DataKit"),
    ],
    targets: [
        .target(
            name: "ReceiptCapture",
            dependencies: [
                .product(name: "DataKit", package: "DataKit")
            ]
        ),
        .testTarget(
            name: "ReceiptCaptureTests",
            dependencies: ["ReceiptCapture"]
        ),
    ]
)
