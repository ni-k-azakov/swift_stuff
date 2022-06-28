//
//  WhichTaxiResponse.swift
//  WhichWay
//
//  Created by Nikita Kazakov on 15.06.2022.
//

import Foundation

struct WhichTaxiResponse: Codable {
    let costInfo: [String: Int]
    let seconds: Int
}
