//
//  MatchHistoryViewModel.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 04.06.2023.
//

import Foundation

typealias HeroWinrate = (hero: Dota.Hero, wins: Int, loses: Int, winrate: Float)
typealias Winrate = (wins: Int, loses: Int, winrate: Float)

final class MatchHistoryViewModel: ObservableObject {
    @Published var profileInfo: SteamProfile
    @Published var matches: [DotaMatchDetailsDTO] = []
    @Published var gmWinrates: [Dota.Match.GameMode: Winrate] = [:]
    @Published var bestHeroWinrate: HeroWinrate?
    @Published var mostPlayedHeroWinrate: HeroWinrate?
    @Published var mostPlayedGM: (Dota.Match.GameMode, Winrate)?
    @Published var bestGM: (Dota.Match.GameMode, Winrate)?
    
    let generalDataManager = GeneralDataManager()
    
    private let steamNetworkManager = SteamNetworkManager()
    
    init(profileInfo: SteamProfile) {
        self.profileInfo = profileInfo
        
        Task {
            if let newProfileInfo = await fetchNewProfileInfo() {
                await MainActor.run { [weak self] in self?.profileInfo = newProfileInfo }
            }
            await fetchLastMatches()
        }
    }
    
    func fetchNewProfileInfo() async -> SteamProfile? {
        guard let summary = await steamNetworkManager.getUserSummary(id: profileInfo.id) else { return nil }
        return SteamProfile(from: summary, level: await steamNetworkManager.getLevel(of: summary.id))
    }
    
    func fetchLastMatches() async {
        let matchHistory = await steamNetworkManager.getMatchHistory(steamID: profileInfo.id, amount: 100)
        guard !matchHistory.isEmpty else { return }
        
        let detailedMatchHistory: [DotaMatchDetailsDTO] = await ParallelAsyncFetcher(onFetch: steamNetworkManager.getMatchDetails
        )
        .setArguments(matchHistory.map { $0.matchID })
        .fetch()
        
        await MainActor.run {
            matches = detailedMatchHistory.sorted { $0.startedAt > $1.startedAt }
        }
        
        await analyze(for: profileInfo.id)
    }
    
    @MainActor func analyze(for user: String) {
        let id32 = user.toSteamID32()
        var heroesWinrate: [Int: HeroWinrate] = [:]
        for match in matches {
            let dotaMatch = Dota.Match(from: match)
            guard let playerInfo = dotaMatch.players.first(where: { $0.steamID32 == id32 }) else { continue }
            let didWin = dotaMatch.winner == playerInfo.team
            
            if let winrate = gmWinrates[dotaMatch.gameMode] {
                let newWin = winrate.wins + (didWin ? 1 : 0)
                let newLose = winrate.loses + (didWin ? 0 : 1)
                gmWinrates[dotaMatch.gameMode] = (
                    wins: newWin,
                    loses: newLose,
                    winrate: Float(newWin) / Float(newWin + newLose)
                )
            } else {
                gmWinrates[dotaMatch.gameMode] = (
                    wins: didWin ? 1 : 0,
                    loses: didWin ? 0 : 1,
                    winrate: didWin ? 1 : 0
                )
            }
            
            if dotaMatch.gameMode != .none {
                if let winrate = gmWinrates[.none] {
                    let newWin = winrate.wins + (didWin ? 1 : 0)
                    let newLose = winrate.loses + (didWin ? 0 : 1)
                    gmWinrates[.none] = (
                        wins: newWin,
                        loses: newLose,
                        winrate: Float(newWin) / Float(newWin + newLose)
                    )
                } else {
                    gmWinrates[.none] = (
                        wins: didWin ? 1 : 0,
                        loses: didWin ? 0 : 1,
                        winrate: didWin ? 1 : 0
                    )
                }
            }
            
            if let winrate = heroesWinrate[playerInfo.heroID] {
                let newWin = winrate.wins + (didWin ? 1 : 0)
                let newLose = winrate.loses + (didWin ? 0 : 1)
                heroesWinrate[playerInfo.heroID] = (
                    hero: winrate.hero,
                    wins: newWin,
                    loses: newLose,
                    winrate: Float(newWin) / Float(newWin + newLose)
                )
            } else {
                guard let hero = generalDataManager.getHero(withID: playerInfo.heroID) else { continue }
                heroesWinrate[playerInfo.heroID] = (
                    hero: hero,
                    wins: didWin ? 1 : 0,
                    loses: didWin ? 0 : 1,
                    winrate: didWin ? 1 : 0
                )
            }
        }
        
        for winrate in heroesWinrate.values {
            analyzeBest(winrate: winrate)
            analyzeMost(winrate: winrate)
        }
        
        print(gmWinrates)
        
        analyzeBestGM()
        analyzeMostPlayedGM()
    }
    
    func analyzeBest(winrate: HeroWinrate) {
        guard winrate.loses + winrate.wins > 5 else { return }
        guard let best = bestHeroWinrate else { bestHeroWinrate = winrate; return }
        if best.winrate < winrate.winrate {
            bestHeroWinrate = winrate
        }
    }
    
    func analyzeMost(winrate: HeroWinrate) {
        guard let most = mostPlayedHeroWinrate else { mostPlayedHeroWinrate = winrate; return }
        if most.wins + most.loses < winrate.wins + winrate.loses {
            mostPlayedHeroWinrate = winrate
        }
    }
    
    func analyzeMostPlayedGM() {
        let element = gmWinrates.filter { $0.key != .none }.max { ($0.value.wins + $0.value.loses) < ($1.value.wins + $1.value.loses) }
        
        if let element {
            mostPlayedGM = (element.key, element.value)
        } else {
            mostPlayedGM = nil
        }
    }
    
    func analyzeBestGM() {
        let element = gmWinrates.filter { $0.key != .none }.max { $0.value.winrate < $1.value.winrate }
        
        if let element {
            bestGM = (element.key, element.value)
        } else {
            bestGM = nil
        }
    }
}
