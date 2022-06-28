//
//  GoogleMapsGeocodingApi.swift
//  WhichWay
//
//  Created by Nikita Kazakov on 10.06.2022.
//

import Foundation

protocol GeocodingProtocol {
    func geocode(adress: String, completion: @escaping (Result<GeocoderLocation, Error>) -> Void)
    func getGeocodeFrom(adress: String)
    func getGeocodeTo(adress: String)
}

protocol TaxiAgregatorProtocol: TaxiFareProtocol, WhichTaxiProtocol, AnotherTaxiProtocol {
    func agregateTaxiResponses(from: GeocoderLocation, to: GeocoderLocation) -> Result<[String : TaxiInfo], Error>
    func getTaxiResponses(fromAdress: String, toAdress: String) async -> Result<[String: TaxiInfo], Error>
}

protocol TaxiFareProtocol {
    func getTaxiFairResponse(from: GeocoderLocation, to: GeocoderLocation, completion: @escaping (Result<[String: Int], Error>) -> Void)
}

protocol WhichTaxiProtocol {
    func getWhichTaxiResponse(fromLat: Float, fromLng: Float, toLat: Float, toLng: Float, completion: @escaping (Result<WhichTaxiResponse, Error>) -> Void)
}

protocol AnotherTaxiProtocol {
    func getAnotherTaxiResponse(from: GeocoderLocation, to: GeocoderLocation, completion: @escaping (Result<[String: Int], Error>) -> Void)
}
