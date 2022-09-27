//
//  Renderer.swift
//  LearningMetal
//
//  Created by Nikita Kazakov on 27.09.2022.
//

import MetalKit

class Renderer: NSObject {
    var gameObjects: [Node] = [Player()]
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // Когда меняется размер окна
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        let commandBuffer = Engine.CommandQueue .makeCommandBuffer()
        
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        for object in gameObjects {
            object.render(renderCommandEncoder: renderCommandEncoder!)
        }
        renderCommandEncoder?.endEncoding()
        
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
