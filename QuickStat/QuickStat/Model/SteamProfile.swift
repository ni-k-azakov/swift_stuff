//
//  SteamProfile.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 26.04.2023.
//

import SwiftUI

struct SteamProfile: Codable {
    let id: String
    let name: String
    let avatarSmall: URL?
    let avatarMedium: URL?
    let avatarFull: URL?
    let state: SteamProfileState
    let lastLogOff: Int
    let countryCode: String?
    let level: Int?
    let currentGameTitle: String?
    
    init(from dto: SteamProfileDTO, level: Int?) {
        self.id = dto.id
        self.name = dto.name
        self.avatarSmall = URL(string: dto.avatar)
        self.avatarMedium = URL(string: dto.avatarMedium)
        self.avatarFull = URL(string: dto.avatarFull)
        self.state = SteamProfileState(rawValue: dto.personaState) ?? .offline
        self.lastLogOff = dto.lastLogOff
        self.countryCode = dto.country
        self.level = level
        self.currentGameTitle = dto.currentGameTitle
    }
    
    var statusBadgeText: String {
        currentGameTitle != nil ? currentGameTitle! : state.text
    }
    
    var statusBadgeColor: Color {
        currentGameTitle != nil ? .yellow : state.color
    }
    
    static func dummy() -> Self {
        SteamProfile(
            from: SteamProfileDTO(
                id: "",
                visibility: 0,
                state: 0,
                name: "",
                commentPermission: 0,
                profileURL: "",
                lastLogOff: 0,
                personaState: 0,
                personaStateFlags: 0,
                avatar: "",
                avatarMedium: "",
                avatarFull: "",
                avatarHash: "",
                realName: "",
                clanID: "",
                createdAt: 0,
                currentGameID: "",
                currentGameServerIP: "",
                currentGameTitle: "",
                country: "",
                stateCode: "",
                cityID: 0
            ),
            level: 0
        )
    }
}

enum SteamProfileState: Int, Codable {
    case offline = 0
    case online = 1
    case busy = 2
    case away = 3
    case snooze = 4
    case lookingToTrade = 5
    case lookingtoPlay = 6
    
    var color: Color {
        switch self {
        case .offline: return .white.opacity(0.7)
        case .online: return .cyan
        case .busy: return Colors.peach
        case .away: return .cyan.opacity(0.7)
        case .snooze: return .cyan.opacity(0.7)
        case .lookingToTrade: return .orange
        case .lookingtoPlay: return Colors.mint.light
        }
    }
    
    var text: String {
        switch self {
        case .offline: return "Не в сети"
        case .online: return "Онлайн"
        case .busy: return "Занят"
        case .away: return "Отошёл"
        case .snooze: return "Спит"
        case .lookingToTrade: return "Хочет обмен"
        case .lookingtoPlay: return "Хочет играть"
        }
    }
}
