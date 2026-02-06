// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package: Package = Package(
    name: "DiscogsKit",
    platforms: [
        .iOS(.v17),
		.macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "DiscogsKit",
            targets: ["DiscogsKit"]),
    ],
    targets: [
        .target(
            name: "DiscogsKit"),
        .testTarget(
            name: "DiscogsKitTests",
            dependencies: ["DiscogsKit"],
			resources: [
				.process("Data")
			]
        ),
    ]
)
