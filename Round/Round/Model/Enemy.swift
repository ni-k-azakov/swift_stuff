//
//  Enemy.swift
//  Round
//
//  Created by Nikita Kazakov on 18.06.2023.
//

import Foundation

struct Enemy {
    let image: String
    let name: String
    let level: UInt8
    let maxHP: Int
    let reward: Double
    
    static func dummy() -> Self {
        Enemy(image: "", name: "", level: 0, maxHP: 0, reward: 0)
    }
}
