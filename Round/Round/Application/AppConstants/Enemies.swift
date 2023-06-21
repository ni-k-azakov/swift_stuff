//
//  AllEnemies.swift
//  Round
//
//  Created by Nikita Kazakov on 20.06.2023.
//

import Foundation

extension AppConstants {
    struct Enemies {
        private init() {}
        
        static private let enemies: [Enemy] = [
            // 0 level
            Enemy(image: Images.Enemies.rock, name: "Rock", level: 0, maxHP: 100, reward: 100),
            // 1 level
            Enemy(image: Images.Enemies.slime.lvl_1, name: "Pitiful Slime", level: 1, maxHP: 150, reward: 200),
            // 2 level
            Enemy(image: Images.Enemies.slime.lvl_2, name: "Big Slime", level: 2, maxHP: 200, reward: 300),
            // 3 level
            Enemy(image: Images.Enemies.goblin.lvl_1, name: "Pitiful Goblin", level: 3, maxHP: 250, reward: 400),
            // 4 level
            Enemy(image: Images.Enemies.goblin.lvl_2, name: "Big Goblin", level: 4, maxHP: 300, reward: 500),
        ]
        
        static func getFor(arenaLevel: UInt8) -> Enemy? {
            guard arenaLevel < enemies.count else { return nil }
            return enemies[Int(arenaLevel)]
        }
    }
}
