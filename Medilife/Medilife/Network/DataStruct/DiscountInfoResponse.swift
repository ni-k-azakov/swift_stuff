//
//  DiscountInfoResponse.swift
//  Medilife
//
//  Created by Nikita Kazakov on 08.06.2022.
//

import Foundation

struct DiscountsInfoResponse: Codable {
    let response: [DiscountInfo]
    let discountID: Int
    let error: Bool
    let message: String
}
