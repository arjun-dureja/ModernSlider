// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "ModernSlider",
    platforms: [
        .macOS(.v13), .iOS(.v15)
    ],
    products: [
        .library(
            name: "ModernSlider",
            targets: ["ModernSlider"]
        )
    ],
    targets: [
        .target(
            name: "ModernSlider",
            dependencies: []
        ),
        .testTarget(
            name: "ModernSliderTests",
            dependencies: ["ModernSlider"]
        )
    ]
)

