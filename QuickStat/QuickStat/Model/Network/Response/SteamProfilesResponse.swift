//
//  SteamProfilesResponse.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 26.04.2023.
//

import Foundation

struct SteamProfilesResponse: Decodable {
    let response: Response
    
    struct Response: Decodable {
        let players: [SteamProfileDTO]
    }
}
