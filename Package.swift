// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "PersonalWebsite",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "PersonalWebsite", targets: ["PersonalWebsite"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.9.0"),
        .package(url: "https://github.com/johnsundell/splashpublishplugin.git", from: "0.2.0"),
        .package(url: "https://github.com/SwiftyGuerrero/CNAMEPublishPlugin", branch: "master"),
        .package(url: "https://github.com/leogdion/ReadingTimePublishPlugin", branch: "patch-2")
    ],
    targets: [
        .executableTarget(
            name: "PersonalWebsite",
            dependencies: [
                .product(name: "Publish", package: "publish"),
                .product(name: "SplashPublishPlugin", package: "splashpublishplugin"),
                "CNAMEPublishPlugin",
                "ReadingTimePublishPlugin"]
        )
    ]
)
