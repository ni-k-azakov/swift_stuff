//
//  DotaMatchOverviewDTO.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 27.04.2023.
//

import Foundation

struct DotaMatchOverviewDTO: Decodable {
    let matchID: Int
    let matchSeqNum: Int
    let startedAt: Int
    let lobbyType: Int
    let radiantTeamID: Int
    let direTeamID: Int
    let players: [Player]
    
    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case matchSeqNum = "match_seq_num"
        case startedAt = "start_time"
        case lobbyType = "lobby_type"
        case radiantTeamID = "radiant_team_id"
        case direTeamID = "dire_team_id"
        case players
    }
    
    struct Player: Decodable {
        let accountID: Int
        let playerSlot: Int
        let teamNumber: Int
        let teamSlot: Int
        let heroID: Int
        
        enum CodingKeys: String, CodingKey {
            case accountID = "account_id"
            case playerSlot = "player_slot"
            case teamNumber = "team_number"
            case teamSlot = "team_slot"
            case heroID = "hero_id"
        }
    }
}
