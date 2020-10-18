// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "UsbtKit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(name: "UsbtKit",
                 targets: ["UsbtKit"]),
    ],
    targets: [
        .target(name: "UsbtKit"),
        .testTarget(name: "UsbtKitTests",
                    dependencies: ["UsbtKit"]),
    ]
)
