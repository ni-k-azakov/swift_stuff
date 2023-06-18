//
//  AppConstants.swift
//  Round
//
//  Created by Nikita Kazakov on 15.06.2023.
//

import Foundation

typealias CGPriority = CGFloat

struct AppConstants {
    private init() {}
    
    struct Priority {
        private init() {}
        
        static let BACKGROUND: CGPriority = -1000
        
        static let GROUND: CGPriority = -1
        static let PLAYER: CGPriority = 0
        static let ENEMY: CGPriority = 1
        static let UI: CGPriority = 999
        
        static let FOREGROUND: CGPriority = 1000
    }
}
