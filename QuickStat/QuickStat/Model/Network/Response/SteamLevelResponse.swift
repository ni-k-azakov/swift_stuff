//
//  SteamLevelResponse.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 27.04.2023.
//

import Foundation

struct SteamLevelResponse: Decodable {
    let response: Response
    
    struct Response: Decodable {
        let level: Int
        
        enum CodingKeys: String, CodingKey {
            case level = "player_level"
        }
    }
}
