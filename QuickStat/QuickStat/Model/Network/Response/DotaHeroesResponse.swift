//
//  DotaHeroesResponse.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 29.04.2023.
//

import Foundation

struct DotaHeroesResponse: Decodable {
    let result: Response
    
    struct Response: Decodable {
        let heroes: [DotaHeroDTO]
    }
}
