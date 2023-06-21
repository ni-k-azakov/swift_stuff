//
//  PlayerController.swift
//  Round
//
//  Created by Nikita Kazakov on 17.06.2023.
//

import Foundation
import SpriteKit

final class PlayerController {
    var avatar: SKSpriteNode!
    var persona: SKSpriteNode!
    
    private(set) var networth: Double = 0
    private(set) var dealtDamage: UInt = 0
    
    private var damage: UInt = 20
    
    func initPersona(in frame: CGRect) {
        persona = SKSpriteNode(imageNamed: "cat")
        persona.zPosition = AppConstants.Priority.PLAYER
        persona.aspectFitTo(size: frame.size)
        persona.position = frame.origin
    }
    
    func initAvatar(in frame: CGRect) {
        avatar = SKSpriteNode(imageNamed: "cat_mini")
        avatar.zPosition = AppConstants.Priority.PLAYER
        avatar.aspectFitTo(size: frame.size)
        avatar.position = frame.origin
    }
    
    func dealDamage() {
        dealtDamage += damage
    }
    
    func resetDamage() {
        dealtDamage = 0
    }
    
    func collectMoney(_ amount: Double) {
        networth += amount
    }
}
