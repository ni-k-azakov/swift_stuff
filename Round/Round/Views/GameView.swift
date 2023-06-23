//
//  GameView.swift
//  Round
//
//  Created by Nikita Kazakov on 23.06.2023.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    let scene = SKScene(fileNamed: "GameScene")! as! GameScene
    
    var body: some View {
        SKRepresentable(scene: scene)
    }
    
    func bind(onMoneyChange: @escaping (Double) -> Void, onCurrentRunChange: @escaping (Double) -> Void) -> Self {
        scene.bind(onMoneyChange: onMoneyChange, onCurrentRunChange: onCurrentRunChange)
        return self
    }
}
