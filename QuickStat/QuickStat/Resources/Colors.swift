//
//  Colors.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 08.04.2023.
//

import SwiftUI

struct Colors {
    static let peach = Color("Peach")
    static let crimson = Color("Crimson")
    static let darkwave = Color("Darkwave")
    
    struct steam {
        private static let path = "Steam/"
        
        static let dark = Color(Self.path + "dark")
        static let light = Color(Self.path + "light")
    }
    
    struct yellow {
        private static let path = "Yellow/"
        
        static let dark = Color(Self.path + "dark")
    }
    
    struct mint {
        private static let path = "Mint/"
        
        static let light = Color(Self.path + "light")
        static let dark = Color(Self.path + "dark")
    }
}
