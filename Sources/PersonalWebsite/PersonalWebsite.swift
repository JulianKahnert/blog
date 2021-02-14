import Foundation
import Plot
import Publish

struct PersonalWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts, about
    }

    struct ItemMetadata: WebsiteItemMetadata {
        var title: String?
        var description: String?
        var date: Date?
        var tags: String?
    }

    let url = URL(string: "https://juliankahnert.de")!
    let name = "ju ka"
    let description = "A tech blog with focus on Swift"
    let language: Language = .english
    var imagePath: Path? { nil }
    var favicon: Favicon? { Favicon(path: "favicon.ico", type: "image/x-icon") }
    var tagHTMLConfig: TagHTMLConfiguration? { .default }
}
