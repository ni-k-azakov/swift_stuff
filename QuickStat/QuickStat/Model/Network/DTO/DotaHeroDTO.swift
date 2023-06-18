//
//  DotaHeroDTO.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 29.04.2023.
//

import Foundation

struct DotaHeroDTO: Decodable {
    let id: Int
    let name: String
    let localized_name: String?
}
