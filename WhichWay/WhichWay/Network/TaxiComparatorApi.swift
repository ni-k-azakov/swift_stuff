//
//  TaxiInfoApi.swift
//  WhichWay
//
//  Created by Nikita Kazakov on 10.06.2022.
//

import Foundation

class TaxiComparatorApi: GeocodingProtocol, TaxiAgregatorProtocol {
    var locationFrom: Result<GeocoderLocation, Error> = .success(GeocoderLocation(lat: 0, lng: 0))
    var locationTo: Result<GeocoderLocation, Error> = .success(GeocoderLocation(lat: 0, lng: 0))
    
    func getGeocodeFrom(adress: String) {
        let group = DispatchGroup()
        group.enter()
        geocode(adress: adress) {
            response in
            switch response {
            case .success(let locationResponse):
                print(locationResponse)
                self.locationFrom = .success(locationResponse)
            case .failure(let error):
                self.locationFrom = .failure(error)
            }
            group.leave()
        }
        group.wait()
    }
    
    func getGeocodeTo(adress: String) {
        let group = DispatchGroup()
        group.enter()
        geocode(adress: adress) {
            response in
            switch response {
            case .success(let locationResponse):
                self.locationTo = .success(locationResponse)
            case .failure(let error):
                self.locationTo = .failure(error)
            }
            group.leave()
        }
        group.wait()
    }
    
    func geocode(adress: String, completion: @escaping (Result<GeocoderLocation, Error>) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "8b01978092msh4ddcb0ce82bdbcdp1a067ajsn1c82239e1ba4",
            "X-RapidAPI-Host": "trueway-geocoding.p.rapidapi.com"
        ]
        
        var url = URLComponents(string: "https://trueway-geocoding.p.rapidapi.com/Geocode")!
        url.queryItems = [
            URLQueryItem(name: "address", value: adress),
            URLQueryItem(name: "language", value: "ru")
        ]
        let request = NSMutableURLRequest(url: url.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            do {
                let geocoderResponse = try JSONDecoder().decode(GeocoderResponse.self, from: data)
                if geocoderResponse.results.isEmpty {
                    completion(.failure(URLError(URLError.cannotDecodeRawData, userInfo: ["No data error": 0])))
                } else {
                    completion(.success(geocoderResponse.results[0].location))
                }
            } catch {
                completion(.failure(URLError(URLError.cannotDecodeRawData, userInfo: ["Decoding error": 0])))
            }
        }
        dataTask.resume()
    }
    
    func getTaxiResponses(fromAdress: String, toAdress: String) -> Result<[String: TaxiInfo], Error> {
        getGeocodeFrom(adress: fromAdress)
        getGeocodeTo(adress: toAdress)
        print("DEBUG API ", locationFrom, locationTo)
        switch locationFrom {
        case .success(let locationFrom):
            switch locationTo {
            case .success(let locationTo):
                return agregateTaxiResponses(from: locationFrom, to: locationTo)
            case .failure(let error):
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func agregateTaxiResponses(from: GeocoderLocation, to: GeocoderLocation) -> Result<[String : TaxiInfo], Error> {
        var errorMsg: Error?
        var result: [String : TaxiInfo] = [:]
        let group = DispatchGroup()
        group.enter()
        getWhichTaxiResponse(fromLat: from.lat, fromLng: from.lng, toLat: to.lat, toLng: to.lng) {
            response in
            switch response {
            case .success(let whichTaxiResponse):
                result["WhichTaxi"] = TaxiInfo(costs: whichTaxiResponse.costInfo, timeInSeconds: whichTaxiResponse.seconds)
            case .failure(let error):
                errorMsg = error
            }
            group.leave()
        }
        group.enter()
        getTaxiFairResponse(from: from, to: to) { response in
            switch response {
            case .success(let fairTaxiResponse):
                self.getTaxiFairTime(from: from, to: to) { response in
                    switch response {
                    case .success(let time):
                        result["FairTaxi"] = TaxiInfo(costs: fairTaxiResponse, timeInSeconds: Int(time * 60))
                    case .failure(let error):
                        result["FairTaxi"] = TaxiInfo(costs: fairTaxiResponse, timeInSeconds: -1)
                        print(error)
                    }
                    group.leave()
                }
            case .failure(let error):
                errorMsg = error
                group.leave()
            }
        }
        group.enter()
        getAnotherTaxiResponse(from: from, to: to) { response in
            switch response {
            case .success(let anotherTaxiResponse):
                result["AnotherTaxi"] = TaxiInfo(costs: anotherTaxiResponse, timeInSeconds: -1)
            case .failure(let error):
                errorMsg = error
            }
            group.leave()
        }
        group.wait()
        if let error = errorMsg, result.isEmpty {
            return .failure(error)
        }
        return .success(result)
    }
    
    func getTaxiFairResponse(from: GeocoderLocation, to: GeocoderLocation, completion: @escaping (Result<[String: Int], Error>) -> Void) {
        var url = URLComponents(string: "http://51.250.101.124:8080/api/ride/price")!
        url.queryItems = [
            URLQueryItem(name: "startlat", value: "\(from.lat)"),
            URLQueryItem(name: "startlon", value: "\(from.lng)"),
            URLQueryItem(name: "endlat", value: "\(to.lat)"),
            URLQueryItem(name: "endlon", value: "\(to.lng)")
        ]
        let request = NSMutableURLRequest(url: url.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            do {
                let costs = try JSONDecoder().decode([FairTaxiResponse].self, from: data)
                print("DEBUG API COSTS ", costs)
                var result: [String: Int] = [:]
                for item in costs {
                    result[item.rideClass] = item.price
                }
                completion(.success(result))
            } catch {
                completion(.failure(URLError(URLError.cannotDecodeRawData, userInfo: ["Decoding error": 0])))
            }
        }
        dataTask.resume()
    }
    
    
    private func getTaxiFairTime(from: GeocoderLocation, to: GeocoderLocation, completion: @escaping (Result<Float, Error>) -> Void) {
        var url = URLComponents(string: "http://51.250.101.124:8080/api/ride/time")!
        url.queryItems = [
            URLQueryItem(name: "startlat", value: "\(from.lat)"),
            URLQueryItem(name: "startlon", value: "\(from.lng)"),
            URLQueryItem(name: "endlat", value: "\(to.lat)"),
            URLQueryItem(name: "endlon", value: "\(to.lng)")
        ]
        let request = NSMutableURLRequest(url: url.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            do {
                let time = try JSONDecoder().decode(Float.self, from: data)
                print("DEBUG API FAIR TAXI TIME ", time)
                completion(.success(time))
            } catch {
                completion(.failure(URLError(URLError.cannotDecodeRawData, userInfo: ["Decoding error": 0])))
            }
        }
        dataTask.resume()
    }
    
    // Татарский переулок 1, Санкт-Петербург, Россия
    // Проспект сизова 32/1, Санкт-Петербург, Россия
    func getWhichTaxiResponse(fromLat: Float, fromLng: Float, toLat: Float, toLng: Float, completion: @escaping (Result<WhichTaxiResponse, Error>) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/calculate/\(fromLat)/\(fromLng)/\(toLat)/\(toLng)")!
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            do {
                let costs = try JSONDecoder().decode(WhichTaxiResponse.self, from: data)
                print("DEBUG API COSTS ", costs)
                completion(.success(costs))
            } catch {
                completion(.failure(URLError(URLError.cannotDecodeRawData, userInfo: ["Decoding error": 0])))
            }
        }
        dataTask.resume()
    }
    
    func getAnotherTaxiResponse(from: GeocoderLocation, to: GeocoderLocation, completion: @escaping (Result<[String: Int], Error>) -> Void) {
        completion(.success([:]))
    }
    
    
}
