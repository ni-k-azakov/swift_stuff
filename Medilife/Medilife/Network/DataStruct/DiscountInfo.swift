//
//  DiscountInfo.swift
//  Medilife
//
//  Created by Nikita Kazakov on 08.06.2022.
//

import Foundation

struct DiscountInfo: Codable, Identifiable {
    let id: Int
    
    let header: String
    let info: String
    let reqularCost: String
    let discountCost: String
    let section: String
    let img: Data
}
