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
    var imagePath: Path? { "img/memoji.png" }
    var favicon: Favicon? { Favicon(path: "img/favicon.png", type: "image/png") }
    var tagHTMLConfig: TagHTMLConfiguration? { .default }
    
    // swiftlint:disable force_unwrapping
    let twitterURL = URL(string: "https://twitter.com/JulianKahnert")!
    let githubURL = URL(string: "https://github.com/JulianKahnert")!
    let xingURL = URL(string: "https://www.xing.com/profile/Julian_Kahnert")!
}
