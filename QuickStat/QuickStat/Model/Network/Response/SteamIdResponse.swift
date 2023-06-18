//
//  SteamIdResponse.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 26.04.2023.
//

import Foundation

struct SteamIdResponse: Decodable {
    let response: Response
    
    struct Response: Decodable {
        let steamid: String?
        let success: Int
    }
}
