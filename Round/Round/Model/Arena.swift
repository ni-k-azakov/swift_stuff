//
//  Arena.swift
//  Round
//
//  Created by Nikita Kazakov on 16.06.2023.
//

import Foundation

typealias Enemy = (name: String, level: Int, hp: Int, reward: Int)
typealias EnemyRoaster = (Enemy?, Enemy?, Enemy?, Enemy?)

struct Arena {
    let background: Int
    let enemies: EnemyRoaster
}
