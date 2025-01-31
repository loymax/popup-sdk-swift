// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoymaxSMC",
    products: [
        .library(
            name: "LoymaxPopupSdk",
            targets: ["LoymaxPopupSdk"]
        ),
        .library(
            name: "SmartCommunications",
            targets: ["SmartCommunications"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Flight-School/AnyCodable",
            from: "0.6.7"
        ),
    ],
    targets: [
        .target(
            name: "LoymaxPopupSdk",
            dependencies: ["AnyCodable"],
            path: "Sources/LoymaxPopupSdk"
        ),
        .testTarget(
            name: "LoymaxPopupSdkTests",
            dependencies: ["LoymaxPopupSdk"],
            path: "Tests/LoymaxPopupSdkTests"
        ),
        .target(
            name: "SmartCommunications",
            dependencies: ["AnyCodable"],
            path: "SmartCommunicationsSDK/Sources/SmartCommunications"
        )
    ]
)
