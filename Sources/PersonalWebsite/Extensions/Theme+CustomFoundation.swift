//
//  CustomFoundationTheme.swift
//  
//
//  Created by Julian Kahnert on 28.01.21.
//

import Foundation
import Plot
import Publish

public extension Theme {
    /// The default "Foundation" theme that Publish ships with, a very
    /// basic theme mostly implemented for demonstration purposes.
    static var customFoundation: Self {
        Theme(
            htmlFactory: FoundationHTMLFactory(),
            resourcePaths: Set(styleFiles.map { Path("css/\($0)") })
        )
    }
}

private let styleFiles = ["styles.css", "fonts.css", "code.css"]

private struct FoundationHTMLFactory<Site: Website>: HTMLFactory {
    private let resourcePaths = styleFiles.map(Path.init)

    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site, stylesheetPaths: resourcePaths),
            .body(
                .header(for: context, selectedSection: nil),
                .hr(),
                .wrapper(
                    .h1(.text(index.title)),
                    .p(
                        .class("description"),
                        .text(context.site.description)
                    ),
                    .h2("Latest content"),
                    .itemList(
                        for: context.allItems(
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site, stylesheetPaths: resourcePaths),
            .body(
                .header(for: context, selectedSection: section.id),
                .hr(),
                .if(section.items.isEmpty,
                    .wrapper(.contentBody(section.body)),
                    else: .wrapper(
                        .h1(.text(section.title)),
                        .itemList(for: section.items, on: context.site)
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site, stylesheetPaths: resourcePaths),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .hr(),
                .wrapper(
                    .article(
                        .h1(.text(item.title)),
                        .div(
                            .class("content"),
                            .contentBody(item.body)
                        ),
                        .span("Tagged with: "),
                        .tagList(for: item, on: context.site)
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site, stylesheetPaths: resourcePaths),
            .body(
                .header(for: context, selectedSection: nil),
                .hr(),
                .wrapper(.contentBody(page.body)),
                .footer(for: context.site)
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site, stylesheetPaths: resourcePaths),
            .body(
                .header(for: context, selectedSection: nil),
                .hr(),
                .wrapper(
                    .h1("Browse all tags"),
                    .ul(
                        .class("all-tags"),
                        .forEach(page.tags.sorted()) { tag in
                            .li(
                                .class("tag \(TagColor.getColorClass(for: tag.string).cssClass)"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site, stylesheetPaths: resourcePaths),
            .body(
                .header(for: context, selectedSection: nil),
                .hr(),
                .wrapper(
                    .h1(
                        "Tagged with ",
                        .span(.class("tag \(TagColor.getColorClass(for: page.tag.string).cssClass)"),
                              .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Browse all tags"),
                        .href(context.site.tagListPath)
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }

    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
            .wrapper(
                .a(.class("site-name"), .href("/"), .text(context.site.name)),
                .if(sectionIDs.count > 1,
                    .nav(
                        .ul(.forEach(sectionIDs) { section in
                            .li(.a(
                                .class(section == selectedSection ? "selected" : ""),
                                .href(context.sections[section].path),
                                .text(context.sections[section].title)
                            ))
                        })
                    )
                )
            )
        )
    }

    static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "en")
        formatter.dateStyle = .medium
        return formatter
    }()
    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .div(
                        .class("metadata-header"),
                        .span(.text(formatter.string(from: item.date))),
                        .unwrap(item.readingTime.minutes, { .span("\($0) min") })
                    ),
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                    )),
                    .p(.text(item.description)),
                    .tagList(for: item, on: site)
                ))
            }
        )
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags.sorted { $0.string < $1.string }) { tag in
            .li(.class(TagColor.getColorClass(for: tag.string).cssClass),
                .a(
                    .href(site.path(for: tag)),
                    .text(tag.string)
            ))
        })
    }

    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            ),
            .unwrap(site as? PersonalWebsite) { site in
                .p(
                    .a(.class("social-icon"), .target(.blank), .href("/feed.rss"), .img(.src("/img/logo-rss.svg"))),
                    .a(.class("social-icon"), .target(.blank), .href(site.twitterURL.absoluteString), .img(.src("/img/logo-twitter.svg"))),
                    .a(.class("social-icon"), .target(.blank), .href(site.githubURL.absoluteString), .img(.src("/img/logo-github.svg"))),
                    .a(.class("social-icon"), .target(.blank), .href(site.xingURL.absoluteString), .img(.src("/img/logo-xing.svg")))
                )
            }
        )
    }
}


public extension Node where Context == HTML.DocumentContext {
    /// Add an HTML `<head>` tag within the current context, based
    /// on inferred information from the current location and `Website`
    /// implementation.
    /// - parameter location: The location to generate a `<head>` tag for.
    /// - parameter site: The website on which the location is located.
    /// - parameter titleSeparator: Any string to use to separate the location's
    ///   title from the name of the website. Default: `" | "`.
    /// - parameter stylesheetPaths: The paths to any stylesheets to add to
    ///   the resulting HTML page. Default: `styles.css`.
    /// - parameter rssFeedPath: The path to any RSS feed to associate with the
    ///   resulting HTML page. Default: `feed.rss`.
    /// - parameter rssFeedTitle: An optional title for the page's RSS feed.
    static func customHead<T: Website>(
        for location: Location,
        on site: T,
        titleSeparator: String = " | ",
        stylesheetPaths: [Path] = ["/styles.css"],
        rssFeedPath: Path? = .defaultForRSSFeed,
        rssFeedTitle: String? = nil
    ) -> Node {
        var title = location.title

        if title.isEmpty {
            title = site.name
        } else {
            title.append(titleSeparator + site.name)
        }

        var description = location.description

        if description.isEmpty {
            description = site.description
        }

        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .unwrap(site.imagePath?.absoluteString) { path in
                .meta(.name("og:image"), .content(path + "favicon.png"))
            },
            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
            .forEach(stylesheetPaths, { .stylesheet($0) }),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .unwrap(rssFeedPath, { path in
                let title = rssFeedTitle ?? "Subscribe to \(site.name)"
                return .rssFeedLink(path.absoluteString, title: title)
            }),
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            })
        )
    }
}
//
//public extension Node where Context == HTML.HeadContext {
//    /// Link the HTML page to an external CSS stylesheet.
//    /// - parameter path: The absolute path of the stylesheet to link to.
//    static func stylesheet(_ path: Path) -> Node {
//        .stylesheet(path.absoluteString)
//    }
//
//    /// Declare a favicon for the HTML page.
//    /// - parameter favicon: The favicon to declare.
//    static func favicon(_ favicon: Favicon) -> Node {
//        .favicon(favicon.path.absoluteString, type: favicon.type)
//    }
//}
//
//public extension Node where Context: HTML.BodyContext {
//    /// Render a location's `Content.Body` as HTML within the current context.
//    /// - parameter body: The body to render.
//    static func contentBody(_ body: Content.Body) -> Node {
//        .raw(body.html)
//    }
//
//    /// Render a string of inline Markdown as HTML within the current context.
//    /// - parameter markdown: The Markdown string to render.
//    /// - parameter parser: The Markdown parser to use. Pass `context.markdownParser` to
//    ///   use the same Markdown parser as the main publishing process is using.
//    static func markdown(_ markdown: String,
//                         using parser: MarkdownParser = .init()) -> Node {
//        .raw(parser.html(from: markdown))
//    }
//
//    /// Add an inline audio player within the current context.
//    /// - Parameter audio: The audio to add a player for.
//    /// - Parameter showControls: Whether playback controls should be shown to the user.
//    static func audioPlayer(for audio: Audio,
//                            showControls: Bool = true) -> Node {
//        return .audio(
//            .controls(showControls),
//            .source(.type(audio.format), .src(audio.url))
//        )
//    }
//
//    /// Add an inline video player within the current context.
//    /// - Parameter video: The video to add a player for.
//    /// - Parameter showControls: Whether playback controls should be shown to the user.
//    ///   Note that this parameter is only relevant for hosted videos.
//    static func videoPlayer(for video: Video,
//                            showControls: Bool = true) -> Node {
//        switch video {
//        case .hosted(let url, let format):
//            return .video(
//                .controls(showControls),
//                .source(.type(format), .src(url))
//            )
//        case .youTube(let id):
//            let url = "https://www.youtube-nocookie.com/embed/" + id
//            return .iframeVideoPlayer(forURL: url)
//        case .vimeo(let id):
//            let url = "https://player.vimeo.com/video/" + id
//            return .iframeVideoPlayer(forURL: url)
//        }
//    }
//}
//
//public extension Node where Context: HTMLLinkableContext {
//    /// Assign a path to link the element to, using its `href` attribute.
//    /// - parameter path: The absolute path to assign.
//    static func href(_ path: Path) -> Node {
//        .href(path.absoluteString)
//    }
//}
//
//public extension Attribute where Context: HTMLSourceContext {
//    /// Assign a source to the element, using its `src` attribute.
//    /// - parameter path: The source path to assign.
//    static func src(_ path: Path) -> Attribute {
//        .src(path.absoluteString)
//    }
//}
//
//internal extension Node where Context: RSSItemContext {
//    static func guid<T>(for item: Item<T>, site: T) -> Node {
//        return .guid(
//            .text(item.rssProperties.guid ?? site.url(for: item).absoluteString),
//            .isPermaLink(item.rssProperties.guid == nil && item.rssProperties.link == nil)
//        )
//    }
//
//    static func content<T>(for item: Item<T>, site: T) -> Node {
//        let baseURL = site.url
//        let prefixes = (href: "href=\"", src: "src=\"")
//
//        var html = item.rssProperties.bodyPrefix ?? ""
//        html.append(item.body.html)
//        html.append(item.rssProperties.bodySuffix ?? "")
//
//        var links = [(url: URL, range: ClosedRange<String.Index>, isHref: Bool)]()
//
//        html.scan(using: [
//            Matcher(
//                identifiers: [
//                    .anyString(prefixes.href),
//                    .anyString(prefixes.src)
//                ],
//                terminators: ["\""],
//                handler: { url, range in
//                    guard url.first == "/" else {
//                        return
//                    }
//
//                    let absoluteURL = baseURL.appendingPathComponent(String(url))
//                    let isHref = (html[range.lowerBound] == "h")
//                    links.append((absoluteURL, range, isHref))
//                }
//            )
//        ])
//
//        for (url, range, isHref) in links.reversed() {
//            let prefix = isHref ? prefixes.href : prefixes.src
//            html.replaceSubrange(range, with: prefix + url.absoluteString + "\"")
//        }
//
//        return content(html)
//    }
//}
//
//internal extension Node where Context == PodcastFeed.ItemContext {
//    static func duration(_ duration: Audio.Duration) -> Node {
//        return .duration(
//            hours: duration.hours,
//            minutes: duration.minutes,
//            seconds: duration.seconds
//        )
//    }
//}
//
//private extension Node where Context: HTML.BodyContext {
//    static func iframeVideoPlayer(forURL url: String) -> Node {
//        return .iframe(
//            .frameborder(false),
//            .allow("accelerometer", "encrypted-media", "gyroscope", "picture-in-picture"),
//            .allowfullscreen(true),
//            .src(url)
//        )
//    }
//}
