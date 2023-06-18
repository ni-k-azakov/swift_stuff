//
//  Int.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 28.04.2023.
//

import Foundation

extension Int {
    func time() -> String {
        let minute = (self % 3600) % 60
        let minuteStr = minute < 10 ? "0\(minute)" : "\(minute)"
        return "\(self / 60):\(minuteStr)"
    }
}
