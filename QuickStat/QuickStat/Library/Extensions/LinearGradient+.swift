//
//  LinearGradient+.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 10.04.2023.
//

import SwiftUI

public extension LinearGradient {
    static func redBlue(
        viewWidth width: CGFloat,
        leadingOffset leading: CGFloat,
        trailingOffset trailing: CGFloat
    ) -> Self {
        LinearGradient(
            colors: [Colors.crimson, Colors.darkwave],
            startPoint: UnitPoint(x: leading / width, y: UnitPoint.leading.y),
            endPoint: UnitPoint(x: 1 + trailing / width, y: UnitPoint.trailing.y)
        )
    }
    
    static func redBlue() -> Self {
        LinearGradient(
            colors: [Colors.crimson, Colors.darkwave],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    static func mintBlue() -> Self {
        LinearGradient(
            colors: [Colors.mint.light, Colors.darkwave],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    static func pinkRed() -> Self {
        LinearGradient(
            colors: [Colors.peach, Colors.crimson],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
