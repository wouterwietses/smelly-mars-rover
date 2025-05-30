// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "MarsRover",
    products: [
        .library(
            name: "MarsRover",
            targets: ["MarsRover"]
        )
    ],
    targets: [
        .target(
            name: "MarsRover",
            dependencies: []
        ),
        .testTarget(
            name: "MarsRoverTests",
            dependencies: ["MarsRover"]
        )
    ]
)
