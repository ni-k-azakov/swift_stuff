//
//  CGPoint+.swift
//  Round
//
//  Created by Nikita Kazakov on 18.06.2023.
//

import Foundation

extension CGPoint {
    static func + (left: CGPoint, right: CGSize) -> CGPoint {
        CGPoint(x: left.x + right.width, y: left.y + right.height)
    }
    
    static func - (left: CGPoint, right: CGSize) -> CGPoint {
        CGPoint(x: left.x - right.width, y: left.y - right.height)
    }
    
    static func * (left: CGPoint, right: CGSize) -> CGPoint {
        CGPoint(x: left.x * right.width, y: left.y * right.height)
    }
    
    static func / (left: CGPoint, right: CGSize) -> CGPoint {
        CGPoint(x: left.x / right.width, y: left.y / right.height)
    }
}
