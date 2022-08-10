// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "PersonalWebsite",
    products: [
        .executable(name: "PersonalWebsite", targets: ["PersonalWebsite"])
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", .branch("master")),
        .package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin.git", from: "0.2.0"),
        .package(url: "https://github.com/SwiftyGuerrero/CNAMEPublishPlugin", from: "0.1.0"),
        .package(url: "https://github.com/alexito4/ReadingTimePublishPlugin", from: "0.2.0")
    ],
    targets: [
        .target(
            name: "PersonalWebsite",
            dependencies: ["Publish", "SplashPublishPlugin", "CNAMEPublishPlugin", "ReadingTimePublishPlugin"]
        )
    ]
)
