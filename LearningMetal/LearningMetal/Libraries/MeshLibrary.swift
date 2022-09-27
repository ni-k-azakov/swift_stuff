//
//  MeshLibrary.swift
//  LearningMetal
//
//  Created by Nikita Kazakov on 27.09.2022.
//

import MetalKit

enum MeshTypes {
    case TRIANGLE_CUSTOM
    case QUAD_CUSTOM
}

class MeshLibrary {
    private  static var meshes: [MeshTypes: Mesh] = [:]
    
    public static func Initialize() {
        createDefaultMesh()
    }
    
    public static func createDefaultMesh() {
        meshes.updateValue(TriangleCustomMesh(), forKey: .TRIANGLE_CUSTOM)
        meshes.updateValue(QuadCustomMesh(), forKey: .QUAD_CUSTOM)
    }
    
    public static func Mesh(_ meshType: MeshTypes) -> Mesh {
        return meshes[meshType]!
    }
}

protocol Mesh {
    var vertexBuffer: MTLBuffer! { get }
    var vertexCount: Int! { get }
}

class CustomMesh: Mesh {
    var vertexBuffer: MTLBuffer!
    var vertices: [Vertex]!
    var vertexCount: Int! {
        return vertices.count
    }
    
    init() {
        createVertices()
        createBuffers()
    }
    
    func createVertices() {}
    
    func createBuffers() {
        vertexBuffer = Engine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
    }
}

class TriangleCustomMesh: CustomMesh {
    override func createVertices() {
        vertices = [
            Vertex(position: simd_float3(0, 1, 0), color: simd_float4(1, 0, 0, 1)),
            Vertex(position: simd_float3(-1, -1, 0), color: simd_float4(0, 1, 0, 1)),
            Vertex(position: simd_float3(1, -1, 0) , color: simd_float4(0, 0, 1, 1))
        ]
    }
}

class QuadCustomMesh: CustomMesh {
    override func createVertices() {
        vertices = [
            Vertex(position: simd_float3(0.5, 0.5, 0), color: simd_float4(1, 0, 0, 1)),
            Vertex(position: simd_float3(-0.5, 0.5, 0), color: simd_float4(0, 1, 0, 1)),
            Vertex(position: simd_float3(-0.5, -0.5, 0) , color: simd_float4(0, 0, 1, 1)),
            Vertex(position: simd_float3(-0.5, -0.5, 0) , color: simd_float4(0, 0, 1, 1)),
            Vertex(position: simd_float3(0.5, 0.5, 0), color: simd_float4(1, 0, 0, 1)),
            Vertex(position: simd_float3(0.5, -0.5, 0), color: simd_float4(1, 1, 0, 1))
        ]
    }
}
