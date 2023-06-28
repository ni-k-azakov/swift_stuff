//
//  SceneDelegate.swift
//  Round
//
//  Created by Nikita Kazakov on 28.06.2023.
//

import SpriteKit

protocol SceneDelegate: AnyObject {
    var screenSize: CGSize { get }
    
    func addChild(_ node: SKNode)
    func addChildren(_ nodes: [SKNode])
}
