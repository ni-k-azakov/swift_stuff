//
//  SteamNetworkManager.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 25.04.2023.
//

import Foundation
import Alamofire

class SteamNetworkManager: NetworkManager {
    var root: String = "http://api.steampowered.com"
}


// MARK: - Profile
extension SteamNetworkManager {
    /// Use to get steam id using user trade link endpoint.
    ///
    /// - Parameter link: User trade link endpoint.
    /// - Returns: Steam id as a string if present, nil otherwise.
    func getSteamID(with link: String) async -> String? {
        let endPoint: EndPoint = .steamID(link: link)
        guard let requestURL = getURL(endPoint: endPoint.path) else { return nil }
        let headers: HTTPHeaders = [HTTPHeader(name: "Content-Type", value: "application/json")]
    
        do {
            return try await AF.request(
                requestURL,
                method: .get,
                encoding: URLEncoding.default,
                headers: headers
            )
            .serializingDecodable(SteamIdResponse.self)
            .value
            .response
            .steamid
        } catch {
            print(getError(error: error, url: requestURL))
            return nil
        }
    }
    
    /// Use to get public information about steam user such as name, avatar or current game.
    ///
    /// - Parameter id: Steam id as string.
    /// - Returns: Info about steam user if present, nil otherwise. Check out ``SteamProfileDTO``.
    func getUserSummary(id: String) async -> SteamProfileDTO? {
        let endPoint: EndPoint = .userSummary(steamID: id)
        guard let requestURL = getURL(endPoint: endPoint.path) else { return nil }
        let headers: HTTPHeaders = [HTTPHeader(name: "Content-Type", value: "application/json")]
        
        do {
            return try await AF.request(
                requestURL,
                method: .get,
                encoding: URLEncoding.default,
                headers: headers
            )
            .serializingDecodable(SteamProfilesResponse.self)
            .value
            .response
            .players
            .first
        } catch {
            print(getError(error: error, url: requestURL))
            return nil
        }
    }
    
    /// Use to get user stream level.
    ///
    /// - Parameter steamID: Steam id as string.
    /// - Returns: Steam level as integer if present, nil otherwise.
    func getLevel(of steamID: String) async -> Int? {
        let endPoint: EndPoint = .steamLevel
        guard let requestURL = getURL(endPoint: endPoint.path) else { return nil }
        let headers: HTTPHeaders = [HTTPHeader(name: "Content-Type", value: "application/json")]
        
        let parameters: [String: Any] = [
            "key": APIKeys.steam,
            "steamid": steamID
        ]
        
        do {
            return try await AF.request(
                requestURL,
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: headers
            )
            .serializingDecodable(SteamLevelResponse.self)
            .value
            .response
            .level
        } catch {
            print(getError(error: error, url: requestURL))
            return nil
        }
    }
}

// MARK: - Match
extension SteamNetworkManager {
    /// Use to get last matches.
    ///
    /// - Parameter steamID: User whose matches you want to get.
    /// - Parameter amount: Maximum 100. By default 25.
    /// - Returns: Array of match overviews. Check out ``DotaMatchOverviewDTO``.
    func getMatchHistory(steamID: String, amount: Int = 25) async -> [DotaMatchOverviewDTO] {
        let parameters: [String: Any] = [
            "key": APIKeys.steam,
            "account_id": steamID,
            "matches_requested": amount
        ]
        
        return await getMatchHistory(parameters: parameters)
    }
    
    private func getMatchHistory(parameters: [String: Any]) async -> [DotaMatchOverviewDTO] {
        let endPoint: EndPoint = .matchHistory
        guard let requestURL = getURL(endPoint: endPoint.path) else { return [] }
        let headers: HTTPHeaders = [HTTPHeader(name: "Content-Type", value: "application/json")]
        
        do {
            return try await AF.request(
                requestURL,
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: headers
            )
            .serializingDecodable(DotaMatchesHistoryResponse.self)
            .value
            .result
            .matches
        } catch {
            print(getError(error: error, url: requestURL))
            return []
        }
    }
    
    /// Use to get detailed information about specific match.
    ///
    /// - Parameter matchID: DoTA match ID.
    /// - Returns: Detailed information if present, nil otherwise. Check out `DotaMatchDetailsDTO`.
    func getMatchDetails(matchID: Int) async -> DotaMatchDetailsDTO? {
        let endPoint: EndPoint = .matchDetails(matchID: matchID)
        guard let requestURL = getURL(endPoint: endPoint.path) else { return nil }
        let headers: HTTPHeaders = [HTTPHeader(name: "Content-Type", value: "application/json")]
        
        do {
            return try await AF.request(
                requestURL,
                method: .get,
                encoding: URLEncoding.default,
                headers: headers
            )
            .serializingDecodable(DotaMatchDetailsResponse.self)
            .value
            .result
        } catch {
            print(getError(error: error, url: requestURL))
            return nil
        }
    }
}

// MARK: - General data
extension SteamNetworkManager {
    /// Use to get all dota heroes.
    ///
    /// - Returns: Array of hero ids, names and localized names. Check out ``DotaHeroDTO``.
    func getHeroesList() async -> [DotaHeroDTO] {
        let endPoint: EndPoint = .heroList
        guard let requestURL = getURL(endPoint: endPoint.path) else { return [] }
        let headers: HTTPHeaders = [HTTPHeader(name: "Content-Type", value: "application/json")]
        
        do {
            return try await AF.request(
                requestURL,
                method: .get,
                encoding: URLEncoding.default,
                headers: headers
            )
            .serializingDecodable(DotaHeroesResponse.self)
            .value
            .result
            .heroes
        } catch {
            print(getError(error: error, url: requestURL))
            return []
        }
    }
}

// MARK: - EndPoint
extension SteamNetworkManager {
    enum EndPoint {
        case steamID(link: String)
        case matchHistory
        case userSummary(steamID: String)
        case steamLevel
        case matchDetails(matchID: Int)
        case heroList
        
        var path: String {
            switch self {
            case let .steamID(link): return "ISteamUser/ResolveVanityURL/v0001/?key=\(APIKeys.steam)&vanityurl=\(link)"
            case .matchHistory: return "IDOTA2Match_570/GetMatchHistory/v1"
            case let .userSummary(steamID): return "ISteamUser/GetPlayerSummaries/v0002/?key=\(APIKeys.steam)&steamids=\(steamID)"
            case .steamLevel: return "IPlayerService/GetSteamLevel/v1"
            case let .matchDetails(matchID): return "IDOTA2Match_570/GetMatchDetails/v1/?key=\(APIKeys.steam)&match_id=\(matchID)"
            case .heroList: return "IEconDOTA2_570/GetHeroes/v1/?language=ru&key=\(APIKeys.steam)"
            }
        }
    }
}
