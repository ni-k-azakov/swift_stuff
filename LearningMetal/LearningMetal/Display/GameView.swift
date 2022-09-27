//
//  GameView.swift
//  LearningMetal
//
//  Created by Nikita Kazakov on 26.09.2022.
//

import MetalKit

class GameView: MTKView {
    var renderer: Renderer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        Engine.Ignite(device: device!)
        
        self.clearColor = Preferences.ClearColor
        self.colorPixelFormat = Preferences.MainPixelFormat
        self.renderer = Renderer()
        self.delegate = renderer
    }
}
