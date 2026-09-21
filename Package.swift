// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimpleToast",
    platforms: [
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "SimpleToast",
            targets: ["SimpleToast"]),
    ],
    targets: [
        .target(
            name: "SimpleToast"),
        .testTarget(
            name: "SimpleToastTests",
            dependencies: ["SimpleToast"]),
    ]
)
