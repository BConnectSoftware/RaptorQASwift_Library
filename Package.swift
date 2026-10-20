
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "RaptorQALibrary",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "RaptorQALibrary",
            targets: ["RaptorQALibrary"]
        )
    ],
    targets: [
        targets: [
                .binaryTarget(
                    name: "RaptorQALibrary",
                    path: "Frameworks/RaptorQALibrary.xcframework"
                )
        ]
    ]
)
