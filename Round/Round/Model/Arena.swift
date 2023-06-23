//
//  Arena.swift
//  Round
//
//  Created by Nikita Kazakov on 16.06.2023.
//

import Foundation

typealias EnemyDispenser = EntityDispencer<Enemy?>

final class Arena {
    let background: UInt
    private(set) var roster: Roster<(Enemy, CGPoint)?> = Roster(nil, nil, nil, nil)
    private let dispencers: Roster<EnemyDispenser>
    
    init(level: UInt, enemyLevels: Roster<UInt8?>, spawnBoxes: Roster<CGRect>) {
        self.background = level
        
        dispencers = enemyLevels.map { level, index in
            // TODO: todo
            guard let level else { return EnemyDispenser(entities: [nil]) }
            return EnemyDispenser(
                entities: [AppConstants.Enemies.getFor(arenaLevel: level)],
                spawnBox: spawnBoxes[index]
            )
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
