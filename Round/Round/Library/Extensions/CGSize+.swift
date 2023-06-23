//
//  CGSize+.swift
//  Round
//
//  Created by Nikita Kazakov on 16.06.2023.
//

import Foundation

extension CGSize {
    static func * (left: CGSize, right: Double) -> CGSize {
        CGSize(width: left.width * right, height: left.height * right)
    }
    
    static func / (left: CGSize, right: Double) -> CGSize {
        CGSize(width: left.width / right, height: left.height / right)
    }
    
    static func + (left: CGSize, right: Double) -> CGSize {
        CGSize(width: left.width + right, height: left.height + right)
    }
    
    static func - (left: CGSize, right: Double) -> CGSize {
        CGSize(width: left.width - right, height: left.height - right)
    }
    
    static func * (left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width * right.width, height: left.height * right.height)
    }
    
    static func / (left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width / right.width, height: left.height / right.height)
    }
    
    static func + (left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width + right.width, height: left.height + right.height)
    }
    
    static func - (left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width - right.width, height: left.height - right.height)
    }
}
