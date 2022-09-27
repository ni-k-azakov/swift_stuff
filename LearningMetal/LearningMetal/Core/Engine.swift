//
//  Engine.swift
//  LearningMetal
//
//  Created by Nikita Kazakov on 27.09.2022.
//

import MetalKit

class Engine {
    public static var Device: MTLDevice!
    public static var CommandQueue: MTLCommandQueue!
    
    public static func Ignite(device: MTLDevice) {
        self.Device = device
        self.CommandQueue = device.makeCommandQueue()
        ShaderLibrary.Initialize()
        VertexDescriptorLibrary.Initialize()
        RPDLibrary.Initialize()
        RPSLibrary.Initialize()
        MeshLibrary.Initialize()
    }
}
