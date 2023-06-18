//
//  CGRect+.swift
//  Round
//
//  Created by Nikita Kazakov on 16.06.2023.
//

import Foundation

extension CGRect {
    var center: CGPoint {
        origin + size / 2
    }
    
    static func * (left: CGRect, right: CGSize) -> CGRect {
        CGRect(x: left.origin.x, y: left.origin.y, width: left.width * right.width, height: left.height * right.height)
    }
    
    static func / (left: CGRect, right: CGSize) -> CGRect {
        CGRect(x: left.origin.x, y: left.origin.y, width: left.width / right.width, height: left.height / right.height)
    }
    
    static func + (left: CGRect, right: CGSize) -> CGRect {
        CGRect(x: left.origin.x, y: left.origin.y, width: left.width + right.width, height: left.height + right.height)
    }
    
    static func - (left: CGRect, right: CGSize) -> CGRect {
        CGRect(x: left.origin.x, y: left.origin.y, width: left.width - right.width, height: left.height - right.height)
    }
    
    static func * (left: CGRect, right: CGPoint) -> CGRect {
        CGRect(x: left.origin.x * right.x, y: left.origin.y * right.y, width: left.width, height: left.height)
    }
    
    static func / (left: CGRect, right: CGPoint) -> CGRect {
        CGRect(x: left.origin.x / right.x, y: left.origin.y / right.y, width: left.width, height: left.height)
    }
    
    static func + (left: CGRect, right: CGPoint) -> CGRect {
        CGRect(x: left.origin.x + right.x, y: left.origin.y + right.y, width: left.width, height: left.height)
    }
    
    static func - (left: CGRect, right: CGPoint) -> CGRect {
        CGRect(x: left.origin.x - right.x, y: left.origin.y - right.y, width: left.width, height: left.height)
    }
}
