//
//  ShaderLib.swift
//  LearningMetal
//
//  Created by Nikita Kazakov on 27.09.2022.
//

import MetalKit

enum VertexShaderTypes {
    case BASIC
}

enum FragmentShaderTypes {
    case BASIC
}

class ShaderLibrary {
    public static var DefaultLibrary: MTLLibrary!
    private static var vertexShaders: [VertexShaderTypes: Shader] = [:]
    private static var fragmentShaders: [FragmentShaderTypes: Shader] = [:]
    
    public static func Initialize() {
        DefaultLibrary = Engine.Device.makeDefaultLibrary()
        createDefaultShaders()
    }
    
    public static func createDefaultShaders() {
        // Vertex Shaders
        vertexShaders.updateValue(BasicVertexShader(), forKey: .BASIC)
        
        // Fragment Shaders
        fragmentShaders.updateValue(BasicFragmentShader(), forKey: .BASIC)
    }
    
    public static func Vertex(_ vertexShaderType: VertexShaderTypes) -> MTLFunction {
        return vertexShaders[vertexShaderType]!.function
    }
    
    public static func Fragment(_ fragmentShaderType: FragmentShaderTypes) -> MTLFunction {
        return fragmentShaders[fragmentShaderType]!.function
    }
}

protocol Shader {
    var name: String { get }
    var functionName: String { get }
    var function: MTLFunction {  get }
}

public struct BasicVertexShader: Shader {
    public var name = "Basic Vertex Shader"
    public var functionName = "basic_vertex_shader"
    public var function: MTLFunction {
        let function = ShaderLibrary.DefaultLibrary.makeFunction(name: functionName)
        function?.label = name
        return function!
    }
}

public struct BasicFragmentShader: Shader {
    public var name = "Basic Fragment Shader"
    public var functionName = "basic_fragment_shader"
    public var function: MTLFunction {
        let function = ShaderLibrary.DefaultLibrary.makeFunction(name: functionName)
        function?.label = name
        return function!
    }
}
