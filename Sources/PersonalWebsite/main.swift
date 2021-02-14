//
//  PersonalWebsite.swift
//
//
//  Created by Julian Kahnert on 22.01.21.
//

import CNAMEPublishPlugin
import Publish
import SplashPublishPlugin

try PersonalWebsite().publish(using: [
    .installPlugin(.splash(withClassPrefix: "")),
    .copyResources(),
    .copyFiles(at: "root-resources"),
    .addMarkdownFiles(),
    .sortItems(by: \.date, order: .descending),
    .installPlugin(.ensureAllItemsAreTagged),
    .installPlugin(.ensureAllPostsHaveMetadata),
    .generateRSSFeed(including: [.posts],
                     config: .default),
    .generateHTML(withTheme: .customFoundation),
    .generateSiteMap(),
    .installPlugin(.addLegacyRedirectsHTML),
    .installPlugin(.generateCNAME(with: "test.juliankahnert.de")),
    .deploy(using: .gitHub("JulianKahnert/blog", branch: "main"))
])
