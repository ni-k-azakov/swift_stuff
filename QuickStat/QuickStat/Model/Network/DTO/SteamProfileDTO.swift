//
//  SteamProfile.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 13.04.2023.
//

import Foundation

/// Steam user profile public information.
struct SteamProfileDTO: Decodable {
    // Public data
    let id: String
    let visibility: Int
    let state: Int?
    let name: String
    let commentPermission: Int?
    let profileURL: String
    let lastLogOff: Int
    let personaState: Int
    let personaStateFlags: Int
    let avatar: String
    let avatarMedium: String
    let avatarFull: String
    let avatarHash: String
    
//     Private data
    let realName: String?
    let clanID: String?
    let createdAt: Int?
    let currentGameID: String?
    let currentGameServerIP: String?
    let currentGameTitle: String?
    let country: String?
    let stateCode: String?
    let cityID: Int?
}

extension SteamProfileDTO {
    enum CodingKeys: String, CodingKey {
        // Public data
        case id = "steamid"
        case visibility = "communityvisibilitystate"
        case state = "profilestate"
        case name = "personaname"
        case commentPermission = "commentpermission"
        case profileURL = "profileurl"
        case lastLogOff = "lastlogoff"
        case personaState = "personastate"
        case personaStateFlags = "personastateflags"
        case avatar
        case avatarMedium = "avatarmedium"
        case avatarFull = "avatarfull"
        case avatarHash = "avatarhash"
        
        // Private data
        case realName = "realname"
        case clanID = "primaryclanid"
        case createdAt = "timecreated"
        case currentGameID = "gameid"
        case currentGameServerIP = "gameserverip"
        case currentGameTitle = "gameextrainfo"
        case country = "loccountrycode"
        case stateCode = "locstatecode"
        case cityID = "loccityid"
    }
}
