//
//  VertexDescriptorLibrary.swift
//  LearningMetal
//
//  Created by Nikita Kazakov on 27.09.2022.
//

import MetalKit

enum VertexDescriptorTypes {
    case BASIC
}

class VertexDescriptorLibrary {
    private static var vertexDescriptors: [VertexDescriptorTypes: VertexDescriptor] = [:]
    
    public static func Initialize() {
        createDefaultVertexDescriptors()
    }
    
    public static func createDefaultVertexDescriptors() {
        vertexDescriptors.updateValue(BasicVertexDescriptor(), forKey: .BASIC)
    }
    
    public static func Descriptor(_ vertexDescriptorType: VertexDescriptorTypes) -> MTLVertexDescriptor {
        return vertexDescriptors[vertexDescriptorType]!.vertexDescriptor 
    }
}

protocol VertexDescriptor {
    var name: String { get }
    var vertexDescriptor: MTLVertexDescriptor { get }
}

class BasicVertexDescriptor: VertexDescriptor {
    var name = "Basic Vertex Descriptor"
    var vertexDescriptor: MTLVertexDescriptor {
        let vertexDescriptor = MTLVertexDescriptor()
        
        //postition
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        //color
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = simd_float3.size
        
        vertexDescriptor.layouts[0].stride = Vertex.stride
        
        return vertexDescriptor
    }
}
