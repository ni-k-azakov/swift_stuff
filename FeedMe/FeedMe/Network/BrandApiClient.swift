//
//  ApiClient.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 28.04.2022.
//

import Foundation

protocol BrandApiClientProtocol {
    func getBrands(completion: @escaping (Result<[BrandJSON], Error>) -> Void)
}

class BrandApiClient: BrandApiClientProtocol {
    func getBrands(completion: @escaping (Result<[BrandJSON], Error>) -> Void) {
        let headers = [
            "X-RapidAPI-Host": "wyre-data.p.rapidapi.com",
            "X-RapidAPI-Key": "8b01978092msh4ddcb0ce82bdbcdp1a067ajsn1c82239e1ba4"
        ]
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: URL(string: "https://wyre-data.p.rapidapi.com/restaurants/town/newcastle")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {
            data, urlResponse, error in
            guard let data = data else {
                completion(.failure(ApiErrors.NO_DATA))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responce = try decoder.decode([BrandJSON].self, from: data)
                completion(.success(responce))
            } catch {
                completion(.failure(error))
            }
        })
        dataTask.resume()
    }
}
