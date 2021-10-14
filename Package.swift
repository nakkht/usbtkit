// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "USBTKit",
    platforms: [
        .macOS(.v11),
        .iOS(.v15)
    ],
    products: [
        .library(name: "USBTKit",
                 targets: ["USBTKit"])
    ],
    targets: [
        .target(name: "USBTKit"),
        .testTarget(name: "USBTKitTests",
                    dependencies: ["USBTKit"])
    ]
)
