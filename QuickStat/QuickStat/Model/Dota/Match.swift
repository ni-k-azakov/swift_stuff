//
//  Match.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 27.04.2023.
//

import Foundation

extension Dota {
    struct Match {
        let duration: Int
        let winner: Side
        let gameMode: GameMode
        let startedAt: Int
        let players: [Player]
        
        init(from dto: DotaMatchDetailsDTO) {
            duration = dto.duration
            winner = dto.didRadiantWin ? .radiant : .dire
            gameMode = GameMode(rawValue: dto.gameMode) ?? .none
            startedAt = dto.startedAt
            
            var playerList: [Player] = []
            for player in dto.players {
                playerList.append(
                    Player(
                        steamID32: player.id,
                        team: player.teamNumber == 0 ? .radiant : .dire,
                        kills: player.kills,
                        deaths: player.deaths,
                        assists: player.assists,
                        gpm: player.goldPerMin,
                        xpm: player.xpPerMin,
                        level: player.level,
                        heroID: player.heroID
                    )
                )
            }
            self.players = playerList
        }
        
        static func dummy() -> Self {
            Match(
                from: DotaMatchDetailsDTO(
                    players: [],
                    didRadiantWin: true,
                    duration: 0,
                    preGameDuration: 0,
                    startedAt: 0,
                    matchID: 0,
                    matchSeqNum: 0,
                    towerStatusRadiant: 0,
                    towerStatusDire: 0,
                    barracksStatusRadiant: 0,
                    barracksStatusDire: 0,
                    cluster: 0,
                    firstBloodTime: 0,
                    lobbyType: 0,
                    humanPlayers: 0,
                    leagueID: 0,
                    positiveVotes: 0,
                    negativeVotes: 0,
                    gameMode: 0,
                    flags: 0,
                    engine: 0,
                    radiantScore: 0,
                    direScore: 0,
                    picksBans: []
                )
            )
        }
    }
}
