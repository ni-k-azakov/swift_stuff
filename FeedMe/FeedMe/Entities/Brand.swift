//
//  Brand.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 22.05.2022.
//

import Foundation

class Brand {
    var logo: String
    var name: String
    var rating: Int?
    var description: String
    var cuisine: String
    
    init(from json: BrandJSON) {
        self.logo = json.logo
        self.name = json.name
        self.rating = Int(json.rating)
        self.description = "Best of the best"
        self.cuisine = "Japanese food"
    }
    
    init(logo: String, name: String, rating: String) {
        self.logo = logo
        self.name = name
        self.rating = Int(rating)
        self.description = "Best of the best"
        self.cuisine = "Japanese food"
    }
}
