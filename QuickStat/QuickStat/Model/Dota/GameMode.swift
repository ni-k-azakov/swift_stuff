//
//  GameMode.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 28.04.2023.
//

import Foundation

extension Dota.Match {
    enum GameMode: Int {
        case none = 0
        case rankedAllPick = 1
        case captainsMode = 2
        case randomDraft = 3
        case singleDraft = 4
        case allRandom = 5
        case intro = 6
        case diretide = 7
        case reverseCaptainsMode = 8
        case theGreeviling = 9
        case tutorial = 10
        case midOnly = 11
        case leastPlayed = 12
        case limitedHeroPool = 13
        case compendiumMatchmaking = 14
        case custom = 15
        case captainsDraft = 16
        case balancedDraft = 17
        case abilityDraft = 18
        case event = 19
        case allRandomDeathMatch = 20
        case soloMid1v1 = 21
        case allPick = 22
        case turbo = 23
        
        var description: String {
            switch self {
            case .none: return "Unknown"
            case .allPick: return "All Pick"
            case .captainsMode: return "Captains Mode"
            case .randomDraft: return "Random Draft"
            case .singleDraft: return "Single Draft"
            case .allRandom: return "All Random"
            case .intro: return "Intro"
            case .diretide: return "Diretide"
            case .reverseCaptainsMode: return "Reverse Captains Mode"
            case .theGreeviling: return "The Greeviling"
            case .tutorial: return "Tutorial"
            case .midOnly: return "Mid Only"
            case .leastPlayed: return "Least Played"
            case .limitedHeroPool: return "Limited Hero Pool"
            case .compendiumMatchmaking: return "Compendium Matchmaking"
            case .custom: return "Custom"
            case .captainsDraft: return "Captains Draft"
            case .balancedDraft: return "Balanced Draft"
            case .abilityDraft: return "Ability Draft"
            case .event: return "Event"
            case .allRandomDeathMatch: return "All Random Deathmatch"
            case .soloMid1v1: return "Solo Mid 1v1"
            case .rankedAllPick: return "Ranked All Pick"
            case .turbo: return "Turbo"
            }
        }
    }
}
