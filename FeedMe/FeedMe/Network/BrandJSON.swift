//
//  Brand.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 20.04.2022.
//

import Foundation
import UIKit

class BrandJSON: Decodable {
    var logo: String
    var name: String
    var rating: String
    
    init(logo: String, name: String, rating: String) {
        self.logo = logo
        self.name = name
        self.rating = rating
    }
    
    enum CodingKeys: String, CodingKey {
        case logo = "_id"
        case name = "BusinessName"
        case rating = "RatingValue"
    }
}
