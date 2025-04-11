//
//  BadgeModel.swift
//  DailyRounds Assignment
//
//  Created by Mohd Saif on 11/04/25.
//
import Foundation

enum BadgeCategory: String, Codable, CaseIterable {
    case trees, leavesFungi, animals
}

struct Badge: Codable {
    let emoji: String
    let category: BadgeCategory

    static func randomBadge() -> Badge {
        let allBadges: [BadgeCategory: [String]] = [
            .trees: ["🌵", "🎄", "🌲", "🌳", "🌴"],
            .leavesFungi: ["🍂", "🍁", "🍄"],
            .animals: ["🐅", "🦅", "🐵", "🐝"]
        ]

        let randomCategory = BadgeCategory.allCases.randomElement()!
        let emoji = allBadges[randomCategory]!.randomElement()!
        return Badge(emoji: emoji, category: randomCategory)
    }
}
