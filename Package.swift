// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "swift-binary-search",
    products: [
        .library(
            name: "BinarySearch",
            targets: ["BinarySearch"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "BinarySearch",
            dependencies: []),
        .testTarget(
            name: "BinarySearchTests",
            dependencies: ["BinarySearch"]),
    ]
)
