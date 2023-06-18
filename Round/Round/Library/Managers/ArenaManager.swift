//
//  ArenaManager.swift
//  Round
//
//  Created by Nikita Kazakov on 16.06.2023.
//

import Foundation


final class ArenaManager {
    private var spawnBoxes: Roaster<CGRect> = Roaster(.zero, .zero, .zero, .zero)
    
    func generateArena(arenaLevel: Int) -> Arena {
        Arena(level: arenaLevel, spawnBoxes: spawnBoxes)
    }
    
    func setSpawnBoxes(_ spawnBoxes: Roaster<CGRect>) {
        self.spawnBoxes = spawnBoxes
    }
}
