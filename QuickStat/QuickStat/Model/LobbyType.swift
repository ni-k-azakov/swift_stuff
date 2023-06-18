//
//  LobbyType.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 28.04.2023.
//

import Foundation

extension Dota.Match {
    enum LobbyType: Int {
        case invalid = -1
        case publicMatchmaking = 0
        case practice = 1
        case tournament = 2
        case tutorial = 3
        case coopWithBots = 4
        case teamMatch = 5
        case soloQueue = 6
        case ranked = 7
        case soloMid1v1 = 8
    }
}
