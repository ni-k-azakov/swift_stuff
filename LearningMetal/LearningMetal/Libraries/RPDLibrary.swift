//
//  RPDLibrary.swift
//  LearningMetal
//
//  Created by Nikita Kazakov on 27.09.2022.
//

import MetalKit

enum RPDTypes {
    case BASIC
}

class RPDLibrary {
    private static var renderPipelineDescriptors: [RPDTypes: RenderPipelineDescriptor] = [:]
    
    public static func Initialize() {
        createDefaultRPD()
    }
    
    public static func createDefaultRPD() {
        renderPipelineDescriptors.updateValue(BasicRPD(), forKey: .BASIC)
    }
    
    public static func Descriptor(_ rpdType: RPDTypes) -> MTLRenderPipelineDescriptor  {
        return renderPipelineDescriptors[rpdType]!.renderPipelineDescriptor
    }
}

protocol RenderPipelineDescriptor {
    var name: String { get }
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor { get }
}

class BasicRPD: RenderPipelineDescriptor {
    var name = "Basic Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.vertexFunction = ShaderLibrary.Vertex(.BASIC)
        renderPipelineDescriptor.fragmentFunction = ShaderLibrary.Fragment(.BASIC)
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptorLibrary.Descriptor(.BASIC)
        return renderPipelineDescriptor
    }
}
