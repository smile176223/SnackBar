// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "SnackBar",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SnackBar",
            targets: ["SnackBar"]),
    ],
    targets: [
        .target(
            name: "SnackBar"),
        .testTarget(
            name: "SnackBarTests",
            dependencies: ["SnackBar"]),
    ]
)
