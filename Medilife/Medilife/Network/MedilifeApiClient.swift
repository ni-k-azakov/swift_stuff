//
//  MedilifeApi.swift
//  Medilife
//
//  Created by Nikita Kazakov on 08.06.2022.
//

import Foundation
import Combine

protocol MedilifeApiClientProtocol {
    func getDiscounts() -> AnyPublisher<DiscountsInfoResponse, Never>
}

class MedilifeApiClient: MedilifeApiClientProtocol {
    static let shared = MedilifeApiClient()
    
    func getDiscounts() -> AnyPublisher<DiscountsInfoResponse, Never> {
        let session = URLSession.shared
        guard let url = URL(string: "http://127.0.0.1:8080/discounts") else {
            return Just(DiscountsInfoResponse(response: [], discountID: -1, error: true, message: "DISCOUNT API ERROR: Incorrect URL")).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: DiscountsInfoResponse.self, decoder: JSONDecoder())
            .replaceError(with: DiscountsInfoResponse(response: [], discountID: -1, error: true, message: "DISCOUNT API ERROR: Data decoding failed"))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
