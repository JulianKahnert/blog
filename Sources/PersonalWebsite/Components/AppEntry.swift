//
//  AppEntry.swift
//
//
//  Created by Julian Kahnert on 02.10.26.
//

/// An app listed on the `/apps` page.
struct AppEntry {
    struct Link {
        let title: String
        let url: String
    }

    let name: String
    let subtitle: String?
    let platforms: String
    let summary: String
    let iconPath: String
    /// CSS class that sets the app's colors, see `css/styles.css`.
    let colorClass: String
    let primaryLink: Link
    let secondaryLink: Link?
}

extension AppEntry {
    static let all: [AppEntry] = [
        AppEntry(
            name: "PDF Archiver",
            subtitle: nil,
            platforms: "iPhone · iPad · Mac",
            summary: "Scan, tag and archive your paper documents. The archive stays plain PDF files in your own iCloud Drive.",
            iconPath: "/img/apps/pdf-archiver.svg",
            colorClass: "app-pdf-archiver",
            primaryLink: Link(title: "App Store", url: "https://apps.apple.com/app/id1352719750"),
            secondaryLink: Link(title: "Source on GitHub", url: "https://github.com/PDF-Archiver/PDF-Archiver")
        ),
        AppEntry(
            name: "Roommate Albert",
            subtitle: nil,
            platforms: "iPhone",
            summary: "Finds your meter photos in the photo library, reads the value and suggests the reading. One tap confirms it.",
            iconPath: "/roommate/app-icon.png",
            colorClass: "app-roommate",
            primaryLink: Link(title: "App Store", url: "https://apps.apple.com/app/id1617545224"),
            secondaryLink: Link(title: "Learn more", url: "/roommate/")
        ),
        AppEntry(
            name: "CodeReview",
            subtitle: nil,
            platforms: "Mac",
            summary: "Keyboard-first diff review. Read every hunk of your working tree or a pull request without touching the mouse.",
            iconPath: "/img/apps/codereview.svg",
            colorClass: "app-codereview",
            primaryLink: Link(title: "App Store", url: "https://apps.apple.com/app/id6799900907"),
            secondaryLink: Link(title: "Learn more", url: "/codereview/")
        ),
        AppEntry(
            name: "Home Automation",
            subtitle: "FlowKit",
            platforms: "Server · iPhone · Mac · Open source",
            summary: "Write HomeKit automations in Swift, test them like any other code, and run them 24/7 on your own server.",
            iconPath: "/img/apps/flowkit.svg",
            colorClass: "app-flowkit",
            primaryLink: Link(title: "GitHub", url: "https://github.com/JulianKahnert/homeautomation"),
            secondaryLink: Link(title: "Setup guide", url: "https://github.com/JulianKahnert/homeautomation/blob/HEAD/docs/setup-server.md")
        )
    ]
}
