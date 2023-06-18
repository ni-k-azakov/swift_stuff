//
//  String+.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 27.04.2023.
//

import Foundation

extension String {
    func flagEmoji() -> String {
        let base : UInt32 = 127397
        var emoji = ""
        for v in self.uppercased().unicodeScalars {
            emoji.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(emoji)
    }
    
    func toSteamID32() -> Int? {
        let min: UInt64 = 76561197960265728
        guard let id = UInt64(self) else { return nil }
        return Int(id - min)
    }
}
