//
//  DotaMatchDetailsDTO.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 27.04.2023.
//

import Foundation

struct DotaMatchDetailsDTO: Decodable {
    let players: [Player]
    let didRadiantWin: Bool
    let duration: Int
    let preGameDuration: Int
    let startedAt: Int
    let matchID: Int
    let matchSeqNum: Int
    let towerStatusRadiant: Int
    let towerStatusDire: Int
    let barracksStatusRadiant: Int
    let barracksStatusDire: Int
    let cluster: Int
    let firstBloodTime: Int
    let lobbyType: Int
    let humanPlayers: Int
    let leagueID: Int
    let positiveVotes: Int
    let negativeVotes: Int
    let gameMode: Int
    let flags: Int
    let engine: Int
    let radiantScore: Int
    let direScore: Int
    let picksBans: [PickBan]
    
    enum CodingKeys: String, CodingKey {
        case didRadiantWin = "radiant_win"
        case preGameDuration = "pre_game_duration"
        case startedAt = "start_time"
        case matchID = "match_id"
        case matchSeqNum = "match_seq_num"
        case towerStatusRadiant = "tower_status_radiant"
        case towerStatusDire = "tower_status_dire"
        case barracksStatusRadiant = "barracks_status_radiant"
        case barracksStatusDire = "barracks_status_dire"
        case firstBloodTime = "first_blood_time"
        case lobbyType = "lobby_type"
        case humanPlayers = "human_players"
        case leagueID = "leagueid"
        case positiveVotes = "positive_votes"
        case negativeVotes = "negative_votes"
        case gameMode = "game_mode"
        case radiantScore = "radiant_score"
        case direScore = "dire_score"
        case picksBans = "picks_bans"
        case players, duration, cluster, flags, engine
    }
    
    struct Player: Decodable {
        let id: Int
        let playerSlot: Int
        let teamNumber: Int
        let teamSlot: Int
        let heroID: Int
        let item_0: Int
        let item_1: Int
        let item_2: Int
        let item_3: Int
        let item_4: Int
        let item_5: Int
        let backpack_0: Int
        let backpack_1: Int
        let backpack_2: Int
        let itemNeutral: Int
        let kills: Int
        let deaths: Int
        let assists: Int
        let leaverStatus: Int
        let lastHits: Int
        let denies: Int
        let goldPerMin: Int
        let xpPerMin: Int
        let level: Int
        let netWorth: Int
        let aghanimsScepter: Int
        let aghanimsShard: Int
        let moonshard: Int
        let heroDamage: Int
        let towerDamage: Int
        let heroHealing: Int
        let gold: Int
        let goldSpent: Int
        let scaledHeroDamage: Int
        let scaledTowerDamage: Int
        let scaledHeroHealing: Int
        let abilityUpgrades: [Ability]
        
        enum CodingKeys: String, CodingKey {
            case id = "account_id"
            case playerSlot = "player_slot"
            case teamNumber = "team_number"
            case teamSlot = "team_slot"
            case heroID = "hero_id"
            case itemNeutral = "item_neutral"
            case leaverStatus = "leaver_status"
            case lastHits = "last_hits"
            case goldPerMin = "gold_per_min"
            case xpPerMin = "xp_per_min"
            case netWorth = "net_worth"
            case aghanimsScepter = "aghanims_scepter"
            case aghanimsShard = "aghanims_shard"
            case heroDamage = "hero_damage"
            case towerDamage = "tower_damage"
            case heroHealing = "hero_healing"
            case goldSpent = "gold_spent"
            case scaledHeroDamage = "scaled_hero_damage"
            case scaledTowerDamage = "scaled_tower_damage"
            case scaledHeroHealing = "scaled_hero_healing"
            case abilityUpgrades = "ability_upgrades"
            case item_0, item_1, item_2, item_3, item_4, item_5, backpack_0, backpack_1, backpack_2, kills, deaths, assists, denies, level, moonshard, gold
        }
        
        struct Ability: Decodable {
            let ability: Int
            let time: Int
            let level: Int
        }
    }
}

struct PickBan: Decodable {
    let isPick: Bool
    let heroID: Int
    let team: Int
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case isPick = "is_pick"
        case heroID = "hero_id"
        case team, order
    }
}
