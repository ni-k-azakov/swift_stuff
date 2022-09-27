//
//  RPSLibrary.swift
//  LearningMetal
//
//  Created by Nikita Kazakov on 27.09.2022.
//

import MetalKit

enum RPSTypes {
    case BASIC
}

class RPSLibrary {
    private static var renderPipelineStates: [RPSTypes: RenderPipelineState] = [:]
    
    public static func Initialize() {
        createDefaultRenderPipelineStates()
    }
    
    public static func createDefaultRenderPipelineStates() {
        renderPipelineStates.updateValue(BasicRPS(), forKey: .BASIC)
    }
    
    public static func PipelineState(_ rpsType: RPSTypes) -> MTLRenderPipelineState {
        return renderPipelineStates[rpsType]!.renderPipelineState
    }
}

protocol RenderPipelineState {
    var name: String { get }
    var renderPipelineState: MTLRenderPipelineState { get }
}

class BasicRPS: RenderPipelineState {
    var name = "Basic Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState {
        var renderPipelineState: MTLRenderPipelineState!
        do {
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: RPDLibrary.Descriptor(.BASIC))
        } catch let error as NSError {
            print(error, name)
        }
        return renderPipelineState
    }
}
