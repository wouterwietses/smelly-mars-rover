// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "smelly-mars-rover",
    products: [
        .executable(name: "smelly-mars-rover", targets: ["smelly-mars-rover"]),
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "smelly-mars-rover",
            dependencies: []),
        .testTarget(
            name: "smelly-mars-roverTests",
            dependencies: ["smelly-mars-rover"]),
    ]
)
