//
//  PublishingStep.swift
//  PersonalWebsite
//
//  Created by Julian Kahnert on 09.09.25.
//

import Foundation
import Publish

extension PublishingStep {
    
    /// Copy the "Resources" folder to the "Output" folder.
    static func copyAllResources() -> Self {
        step(named: "Copy all resources") { context in
            let resourcesfolder = try context.folder(at: "Resources")
            let outputfolder = try context.folder(at: "Output")
            
            try copyFolder(from: resourcesfolder.url, to: outputfolder.url)
        }
    }
}


private func copyFolder(from sourceURL: URL, to destinationURL: URL) throws {
    let fileManager = FileManager.default

    // Check if the source folder exists
    guard fileManager.fileExists(atPath: sourceURL.path) else {
        throw NSError(domain: "com.example.error", code: 404, userInfo: [NSLocalizedDescriptionKey: "Source folder does not exist"])
    }

    // Create the destination folder if it doesn't exist
    try fileManager.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)

    // Iterate over all items in the source folder
    let contents = try fileManager.contentsOfDirectory(at: sourceURL, includingPropertiesForKeys: nil, options: [])

    for item in contents {
        let sourceItem = item
        let destinationItem = destinationURL.appendingPathComponent(item.lastPathComponent)

        if item.hasDirectoryPath {
            // Recursively copy subdirectories to maintain folder structure
            try copyFolder(from: sourceItem, to: destinationItem)
        } else {
            // Copy files
            try fileManager.copyItem(at: sourceItem, to: destinationItem)
        }
    }
}

