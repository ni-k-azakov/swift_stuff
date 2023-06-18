//
//  Color+.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 05.06.2023.
//

import Foundation
import SwiftUI

extension Color {
    static func score(positive: Int, negative: Int) -> Color {
        if positive > negative {
            guard positive != 0 else {
                return .white
            }
            return Color(red: Double(negative) / Double(positive), green: 1, blue: 0)
        } else {
            guard negative != 0 else {
                return .white
            }
            return Color(red: 1, green: Double(positive) / Double(negative), blue: 0)
        }
    }
}
