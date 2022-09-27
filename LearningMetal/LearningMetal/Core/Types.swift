//
//  Types.swift
//  LearningMetal
//
//  Created by Nikita Kazakov on 27.09.2022.
//

import simd

protocol Sizable {}

extension Sizable {
    static var size: Int {
        return MemoryLayout<Self>.size
    }
    static var stride: Int {
        return MemoryLayout<Self>.stride
    }
    static func size(_ count: Int) -> Int {
        return MemoryLayout<Self>.size * count
    }
    static func stride(_ count: Int) -> Int {
        return MemoryLayout<Self>.stride * count
    }
}

struct Vertex: Sizable  {
    var position: simd_float3
    var color: simd_float4
}

extension simd_float3: Sizable {}
