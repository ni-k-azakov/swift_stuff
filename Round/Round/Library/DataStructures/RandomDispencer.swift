//
//  RandomDispencer.swift
//  Round
//
//  Created by Nikita Kazakov on 21.06.2023.
//

import Foundation
import GameplayKit

final class RandomDispencer<Item> {
    private(set) var items: [Item]
    private var entityRandomizer: GKRandomDistribution
    
    init(of items: [Item]) {
        self.items = items
        self.entityRandomizer = .init(forDieWithSideCount: items.count)
    }
    
    func set(items: [Item]) {
        if items.count != self.items.count {
            self.entityRandomizer = .init(forDieWithSideCount: items.count)
        }
        self.items = items
    }
    
    func next() -> Item {
        if items.count == 1 { return items[0] }
        return items[entityRandomizer.nextInt() - 1]
    }
}
