//
//  Plugin.swift
//
//
//  Created by Julian Kahnert on 14.02.21.
//

enum TagColor: String {
    case red
    case orange
    case blue
    case green
    case indigo
    
    static func getColorClass(for tagName: String) -> TagColor {
        guard let firstCharacter = tagName.first else { return .green }
        switch firstCharacter {
        case (Character("a")...Character("c")):
            return .red
        case (Character("d")...Character("o")):
            return .orange
        case (Character("p")...Character("t")):
            return .blue
        case (Character("u")...Character("z")):
            return .green
        default:
            return .indigo
        }
    }
}

extension TagColor {
    var cssClass: String {
        "tag-\(rawValue)"
    }
}
