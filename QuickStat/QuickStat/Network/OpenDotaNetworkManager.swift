//
//  OpenDotaNetworkManager.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 10.04.2023.
//

import Foundation
import Alamofire


final class OpenDotaNetworkManager: NetworkManager {
    var root: String = "https://api.opendota.com"
    
    func getUser(byID id: Int) async -> OpenDotaUser? {
        let endPoint: EndPoint = .player(id: String(id))
        guard let requestURL = getURL(endPoint: endPoint.path) else { return nil }
        
        var headers: HTTPHeaders = [HTTPHeader(name: "Content-Type", value: "application/json")]
        do {
            let user = try await AF.request(
                requestURL,
                method: .get,
                encoding: URLEncoding.default,
                headers: headers
            )
            .serializingDecodable(OpenDotaUser.self)
            .value
            
            return user
        } catch {
            print(getError(error: error, url: requestURL))
            return nil
        }
    }
    
    enum EndPoint {
        case player(id: String)
        
        var path: String {
            switch self {
            case let .player(id): return "api/players/\(id)"
            }
        }
    }
}
