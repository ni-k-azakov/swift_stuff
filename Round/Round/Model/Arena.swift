//
//  Arena.swift
//  Round
//
//  Created by Nikita Kazakov on 16.06.2023.
//

import Foundation

typealias EnemyDispenser = EntityManager<Enemy?>

final class Arena {
    let background: UInt
    private(set) var roster: Roster<(Enemy, CGPoint)?> = Roster(nil, nil, nil, nil)
    private let dispencers: Roster<EnemyDispenser>
    
    init(level: UInt, enemyLevels: Roster<UInt8?>, spawnBoxes: Roster<CGRect>) {
        self.background = level
        
        dispencers = enemyLevels.map { level, index in
            // TODO: todo
            if level == 1 {
                return EnemyDispenser(
                    entities: [Enemy(image: "slime", name: "slime", level: 1, maxHP: 100, reward: 50)],
                    spawnBox: spawnBoxes[index]
                )
            } else if level == 2 {
                return EnemyDispenser(
                    entities: [Enemy(image: "slime2", name: "slime", level: 1, maxHP: 200, reward: 100)],
                    spawnBox: spawnBoxes[index]
                )
            } else {
                return EnemyDispenser(entities: [nil], spawnBox: spawnBoxes[index])
            }
        }
        
        updateRoster()
    }
    
    func setSpawnBoxes(spawnBoxes: Roster<CGRect>) {
        dispencers.forEach { dispencer, index in
            dispencer.set(newSpawnBox: spawnBoxes[index])
        }
    }
    
    func updateRoster() {
        roster = dispencers.map {
            if let entity = $0.nextEntity() {
                return (entity, $0.nextPosition())
            } else {
                return nil
            }
        }
    }
    
    func wipeEnemies() {
        roster = Roster(nil, nil, nil, nil)
    }
}
