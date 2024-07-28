// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "mkapi",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "mkapi", targets: ["mkapi"])
    ],
    dependencies: [
        .package(url: "https://github.com/apparata/SystemKit", exact: "1.7.0"),
        .package(url: "https://github.com/apparata/TextToolbox", exact: "1.2.0"),
        .package(url: "https://github.com/apparata/TemplateKit", exact: "0.7.2"),
        .package(url: "https://github.com/apparata/Constructs", exact: "1.2.0"),
        .package(url: "https://github.com/apparata/CollectionKit", exact: "0.2.2")
    ],
    targets: [
        .executableTarget(
            name: "mkapi",
            dependencies: [
                "SystemKit",
                "TemplateKit"
            ],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
                .define("RELEASE", .when(configuration: .release)),
                .define("SWIFT_PACKAGE")
            ])
    ]
)
