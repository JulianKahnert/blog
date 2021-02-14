//
//  Plugin.swift
//  
//
//  Created by Julian Kahnert on 20.01.21.
//

import Foundation
import Publish

extension Plugin {
    
    static var addLegacyRedirectsHTML: Self {
        Plugin(name: "Ensure that all items are tagged") { context in
            
            guard let postsSection = context.sections.first(where: { $0.id.rawValue == "posts" }) else {
                throw PublishingError(path: "N/A",
                                      infoMessage: "Could not find posts section.")
            }
            let legacyItems = postsSection.items.filter { $0.date.year <= 2020 }

            for legacyItem in legacyItems {
                guard let relativePath = legacyItem.path.string.components(separatedBy: "/").last else {
                    throw PublishingError(path: legacyItem.path,
                                          infoMessage: "Failed to create relative path for legacy item.")
                }
                
                let url = context.site.url.appendingPathComponent(legacyItem.path.string)
                try context.createOutputFile(at: Path("\(relativePath)/index.html")).write(redirectHtml(with: url))
            }
        }
    }
    
    /// Source: https://github.com/JohnSundell/Publish
    static var ensureAllItemsAreTagged: Self {
        Plugin(name: "Ensure that all items are tagged") { context in
            let allItems = context.sections.flatMap { $0.items }

            for item in allItems {
                guard !item.tags.isEmpty else {
                    throw PublishingError(path: item.path,
                                          infoMessage: "Item has no tags")
                }
            }
        }
    }
    
    static var ensureAllPostsHaveMetadata: Self {
        Plugin(name: "Ensure that all items have valid metadata") { context in
            let allItems = context.sections.flatMap { $0.items }

            for item in allItems {
                
                guard let metadata = item.metadata as? PersonalWebsite.ItemMetadata else {
                    throw PublishingError(path: item.path,
                                          infoMessage: "Failed to parse metadata")
                }

                guard !(metadata.title?.isEmpty ?? true) else {
                    throw PublishingError(path: item.path,
                                          infoMessage: "Metadata has no title")
                }
                
                guard !(metadata.description?.isEmpty ?? true) else {
                    throw PublishingError(path: item.path,
                                          infoMessage: "Metadata has no description")
                }
                
                guard metadata.date != nil else {
                    throw PublishingError(path: item.path,
                                          infoMessage: "Metadata has no date")
                }
                
                guard !(metadata.tags?.isEmpty ?? true) else {
                    throw PublishingError(path: item.path,
                                          infoMessage: "Metadata has no tags")
                }
            }
        }
    }
    
    private static func redirectHtml(with url: URL) -> String {
        """
        <!DOCTYPE HTML>
        <html lang="en-US">
            <head>
                <meta charset="UTF-8">
                <meta http-equiv="refresh" content="0; url=\(url.path)">
                <title>Page Redirection</title>
            </head>
            <body>
                <!-- Note: don't tell people to `click` the link, just tell them that it is a link. -->
                If you are not redirected automatically, follow this <a href='\(url.path)'>link to example</a>.
            </body>
        </html>
        """
    }
}
