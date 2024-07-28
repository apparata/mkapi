import Foundation
import TemplateKit

extension Template.Package {

    /// Parameters:
    /// - swiftVersion
    /// - packageName
    /// - libraryName
    /// - targetName
    static let package = Template(#"""
// swift-tools-version: <{ swiftVersion }>

import PackageDescription

let package = Package(
    name: "<{ packageName }>",
    platforms: [
        .iOS(.v15), .macOS(.v13), .tvOS(.v15), .visionOS(.v1)
    ],
    products: [
        .library(name: "<{ libraryName }>", targets: ["<{ targetName }>"])
    ],
    targets: [
        .target(
            name: "<{ targetName }>",
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
                .define("RELEASE", .when(configuration: .release)),
                .define("SWIFT_PACKAGE")
            ])
    ]
)
"""#)
}
