---
date: 2021-01-28 13:36
description: A description of my first post.
tags: first, article
---
# My first post

My first post's text.


```swift
func resolvePublishingDate(fromFile file: File,
                           decoder: MarkdownMetadataDecoder) throws -> Date {
    if let date = try decoder.decodeIfPresent("date", as: Date.self) {
        return date
    }

    return file.modificationDate ?? Date()
}
```
