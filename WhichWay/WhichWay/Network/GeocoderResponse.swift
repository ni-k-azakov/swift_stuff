//
//  GeocoderResponse.swift
//  WhichWay
//
//  Created by Nikita Kazakov on 10.06.2022.
//

import Foundation

struct GeocoderResponse: Codable {
    var results: [GeocoderResults]
}

struct GeocoderResults: Codable {
    var address: String
    var postal_code: String
    var country: String
    var locality: String
    var street: String
    var house: String
    var location: GeocoderLocation
    var location_type: String
    var type: String
}

struct GeocoderLocation: Codable {
    var lat: Float
    var lng: Float
}
