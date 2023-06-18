//
//  CGPriority+.swift
//  Round
//
//  Created by Nikita Kazakov on 15.06.2023.
//

import Foundation

extension CGPriority {
    var particle: CGPriority { self + 0.1 }
    
    func moveFront(_ quantity: UInt) -> CGPriority {
        self + 0.0000001 * CGFloat(quantity)
    }
}
