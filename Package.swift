// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "UsbtKit",
    products: [
        .library(
            name: "UsbtKit",
            targets: ["UsbtKit"]),
    ],
    targets: [
        .target(
            name: "UsbtKit"),
        .testTarget(
            name: "UsbtKitTests",
            dependencies: ["UsbtKit"]),
    ]
)
