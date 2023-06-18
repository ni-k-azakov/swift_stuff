//
//  ArenaManager.swift
//  Round
//
//  Created by Nikita Kazakov on 16.06.2023.
//

import Foundation

typealias RoasterLevels = (Int, Int, Int, Int)

final class ArenaManager {
    func generateArena(arenaLevel: Int, enemyLevels: RoasterLevels) -> Arena {
        Arena(
            background: arenaLevel,
            enemies: EnemyRoaster(
                Enemy(name: "1", level: enemyLevels.0, hp: 20, reward: 200),
                nil,
                nil,
                nil
            )
        )
    }
}
