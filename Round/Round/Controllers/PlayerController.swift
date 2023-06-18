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
    
    func initPersona(in frame: CGRect) {
        persona = SKSpriteNode(imageNamed: "catWarrior")
        persona.zPosition = AppConstants.Priority.PLAYER
        persona.aspectFitTo(size: frame.size)
        persona.position = frame.origin
    }
    
    func initAvatar(in frame: CGRect) {
        avatar = SKSpriteNode(imageNamed: "catWarrior")
        avatar.zPosition = AppConstants.Priority.PLAYER
        avatar.aspectFitTo(size: frame.size)
        avatar.position = frame.origin
    }
}
