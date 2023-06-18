//
//  Arena.swift
//  Round
//
//  Created by Nikita Kazakov on 16.06.2023.
//

import Foundation

typealias EnemyDispenser = EntityManager<Enemy>

final class Arena {
    let background: Int
    private(set) var roaster: Roaster<(Enemy, CGPoint)?> = Roaster(nil, nil, nil, nil)
    
    private let dispencers: Roaster<EnemyDispenser> = Roaster(
        EnemyDispenser(entities: [Enemy(image: "slime", name: "slime", level: 1, maxHP: 100, reward: 50)]),
        EnemyDispenser(entities: [Enemy(image: "slime2", name: "slime", level: 1, maxHP: 100, reward: 50)]),
        EnemyDispenser(entities: [Enemy(image: "slime", name: "slime", level: 1, maxHP: 100, reward: 50)]),
        EnemyDispenser(entities: [Enemy(image: "slime", name: "slime", level: 1, maxHP: 100, reward: 50),])
    )
    
    init(level: Int, spawnBoxes: Roaster<CGRect>) {
        self.background = level
        dispencers.forEach { dispencer, index in
            dispencer.set(newSpawnBox: spawnBoxes[index])
        }
        updateRoaster()
    }
    
    func setSpawnBoxes(spawnBoxes: Roaster<CGRect>) {
        dispencers.forEach { dispencer, index in
            dispencer.set(newSpawnBox: spawnBoxes[index])
        }
    }
    
    func updateRoaster() {
        roaster = dispencers.map { ($0.nextEntity(), $0.nextPosition()) }
    }
    func dealDamage(damage: UInt) {
        // TODO: todo
        roaster = Roaster(nil, nil, nil, nil)
    }
}
