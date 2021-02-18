import Foundation
import Plot
import Publish

struct PersonalWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts, about
    }

    struct ItemMetadata: WebsiteItemMetadata {
        var title: String
        var description: String
        var date: Date
        var tags: String
    }

    let url = URL(string: "https://juliankahnert.de")!
    let name = "ju ka"
    let description = "I will add blogposts about technology with focus on Swift and Kubernetes. 🤓 I would love to get in touch with you. If you have any feedback, questions, ideas, etc. just drop me a line! ✉️"
    let language: Language = .english
    var imagePath: Path? { nil }
    var favicon: Favicon? { Favicon(path: "favicon.ico", type: "image/x-icon") }
    var tagHTMLConfig: TagHTMLConfiguration? { .default }
}
