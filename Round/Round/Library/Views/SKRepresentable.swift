//
//  SKRepresentable.swift
//  Round
//
//  Created by Nikita Kazakov on 23.06.2023.
//

import SwiftUI
import SpriteKit

struct SKRepresentable: UIViewRepresentable {
    typealias UIViewType = SKView
    
    var skScene: SKScene!
    
    init(scene: SKScene) {
        skScene = scene
        self.skScene.scaleMode = .aspectFill
        scene.size = UIScreen.main.bounds.size
    }
    
    class Coordinator: NSObject {
        var scene: SKScene?
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator()
        coordinator.scene = self.skScene
        return coordinator
    }
    
    func makeUIView(context: Context) -> SKView {
        let view = SKView(frame: .zero)
        view.preferredFramesPerSecond = 60
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        
        return view
    }
    
    func updateUIView(_ view: SKView, context: Context) {
        view.presentScene(context.coordinator.scene)
    }
}
