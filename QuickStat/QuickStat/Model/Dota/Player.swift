//
//  Player.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 28.04.2023.
//

import Foundation

extension Dota.Match {
    struct Player {
        let steamID32: Int
        let team: Side
        let kills: Int
        let deaths: Int
        let assists: Int
        let gpm: Int
        let xpm: Int
        let level: Int
        let heroID: Int
        
        static func dummy() -> Self {
            Player(
                steamID32: 0,
                team: .radiant,
                kills: 0,
                deaths: 0,
                assists: 0,
                gpm: 0,
                xpm: 0,
                level: 0,
                heroID: 0
            )
        }
    }
}
