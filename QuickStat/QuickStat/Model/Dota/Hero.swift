//
//  Hero.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 29.04.2023.
//

import Foundation

extension Dota {
    struct Hero: Codable {
        let id: Int
        let localizedName: String?
        let fullName: String
        
        init(from dto: DotaHeroDTO) {
            id = dto.id
            localizedName = dto.localized_name
            fullName = dto.name
        }
    }
}

extension Dota.Hero {
    private var imageUrlBase: String { "https://cdn.dota2.com/apps/dota2/images/heroes" }
    
    var fullImageUrl: URL? { URL(string: "\(imageUrlBase)/\(nameSuffix)_full.png") }
    var largeImageUrl: URL? { URL(string: "\(imageUrlBase)/\(nameSuffix)_lg.png") }
    var smallImageUrl: URL? { URL(string: "\(imageUrlBase)/\(nameSuffix)_sb.png") }
    var verticalImageUrl: URL? { URL(string: "\(imageUrlBase)/\(nameSuffix)_vert.jpg") }
    
    var nameSuffix: String {
        let index = fullName.index(fullName.startIndex, offsetBy: 14)
        return String(fullName.suffix(from: index))
    }
}
