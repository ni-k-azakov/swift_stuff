//
//  ArenaManager.swift
//  Round
//
//  Created by Nikita Kazakov on 16.06.2023.
//

import Foundation


final class ArenaManager {
    private var spawnBoxes: Roster<CGRect> = Roster(.zero, .zero, .zero, .zero)
    
    func generateArenaFrom(config: ArenaConfig) -> Arena {
        Arena(level: config.level, enemyLevels: config.enemyLevels, spawnBoxes: spawnBoxes)
    }
    
    func setSpawnBoxes(_ spawnBoxes: Roster<CGRect>) {
        self.spawnBoxes = spawnBoxes
    }
}
