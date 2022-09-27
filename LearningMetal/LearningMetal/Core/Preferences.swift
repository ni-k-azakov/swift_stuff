//
//  Preferences.swift
//  LearningMetal
//
//  Created by Nikita Kazakov on 27.09.2022.
//

import MetalKit

public enum ClearColors {
    static let WHITE: MTLClearColor = MTLClearColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let GREEN: MTLClearColor = MTLClearColor(red: 0.2, green: 0.7, blue: 0.4, alpha: 1)
    static let RED: MTLClearColor = MTLClearColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1)
    static let BLUE: MTLClearColor = MTLClearColor(red: 0.2, green: 0.2, blue: 0.7, alpha: 1)
    static let GREY: MTLClearColor = MTLClearColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    static let BLACK: MTLClearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 1)
}

class Preferences {
    public static var ClearColor = ClearColors.WHITE
    public static var MainPixelFormat: MTLPixelFormat = .bgra8Unorm
}
