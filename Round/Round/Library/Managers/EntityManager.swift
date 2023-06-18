//
//  EnemyManager.swift
//  Round
//
//  Created by Nikita Kazakov on 15.06.2023.
//

import Foundation
import GameplayKit

final class EntityManager<Entity> {
    let enemyList: [Entity]
    private let enemyRandomizer: GKRandomDistribution
    private var xPositionRandomizer: GKRandomDistribution
    private var yPositionRandomizer: GKRandomDistribution
    private var stepMultiplier: CGFloat
    
    /// Use to get steam id using user trade link endpoint.
    ///
    /// - Parameter enemies: Enemy templates.
    /// - Parameter gridStep: Use numbers above 0. Default 1.
    init(
        entities: [Entity],
        spawnBox field: CGRect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1)),
        gridStep: CGFloat = 1
    ) {
        self.enemyList = entities
        self.enemyRandomizer = .init(forDieWithSideCount: enemyList.count)
        self.stepMultiplier = gridStep > 0 ? 1 / gridStep : 1 / .leastNonzeroMagnitude
        self.xPositionRandomizer = .init(lowestValue: Int(field.minX * stepMultiplier), highestValue: Int(field.maxX * stepMultiplier))
        self.yPositionRandomizer = .init(lowestValue: Int(field.minY * stepMultiplier), highestValue: Int(field.maxY * stepMultiplier))
    }
    
    @discardableResult func set(newSpawnBox field: CGRect, gridStep: CGFloat = 1) -> Self {
        self.stepMultiplier = gridStep > 0 ? 1 / gridStep : 1 / .leastNonzeroMagnitude
        self.xPositionRandomizer = .init(lowestValue: Int(field.minX * stepMultiplier), highestValue: Int(field.maxX * stepMultiplier))
        self.yPositionRandomizer = .init(lowestValue: Int(field.minY * stepMultiplier), highestValue: Int(field.maxY * stepMultiplier))
        return self
    }
    
    func nextEnemy() -> Entity {
        enemyList[enemyRandomizer.nextInt() - 1]
    }
    
    /// Random enemy position in default spawnbox.
    /// - Note: Has static alternative.
    func nextPosition() -> CGPoint {
        CGPoint(
            x: CGFloat(xPositionRandomizer.nextInt()) / stepMultiplier,
            y: CGFloat(yPositionRandomizer.nextInt()) / stepMultiplier
        )
    }
    
    /// Random enemy position in spawnbox.
    /// - Parameter gridStep: Use numbers above 0. Default 1.
    static func nextPosition(inSpawnBox field: CGRect, gridStep: CGFloat = 1) -> CGPoint {
        let tempStepMult = gridStep > 0 ? 1 / gridStep : 1 / .leastNonzeroMagnitude
        let xTempPositionRandomizer = GKRandomDistribution(
            lowestValue: Int(field.minX * tempStepMult),
            highestValue: Int(field.maxX * tempStepMult)
        )
        let yTempPositionRandomizer = GKRandomDistribution(
            lowestValue: Int(field.minY * tempStepMult),
            highestValue: Int(field.maxY * tempStepMult)
        )
        return CGPoint(
            x: CGFloat(xTempPositionRandomizer.nextInt()) / tempStepMult,
            y: CGFloat(yTempPositionRandomizer.nextInt()) / tempStepMult
        )
    }
}
