//
//  SteamProfileFinderViewModel.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 13.04.2023.
//

import SwiftUI

final class SteamProfileFinderViewModel: ObservableObject {
    @Published var userToFind: String = ""
    @Published var profile: SteamProfile?
    @Published var lastMatch: Dota.Match?
    @Published var isLoading: Bool = false
    let openDotaNetworkManager = OpenDotaNetworkManager()
    let steamNetworkManager = SteamNetworkManager()
    
//    func getUsersList() async -> [OpenDotaUser?] {
//        var users: [OpenDotaUser?] = []
//        let amount = Int.random(in: 3...6)
//        for _ in 0..<amount {
//            users.append(await openDotaNetworkManager.getUser(byID: 192536445))
//        }
//        return users
//    }
    
    func findUser() async {
        await MainActor.run {
            withAnimation(.spring()) {
                isLoading = true
            }
        }
        
        defer {
            Task {
                await MainActor.run {
                    withAnimation(.spring()) {
                        isLoading = false
                    }
                }
            }
        }
        
        
        guard userToFind != "" else {
            await MainActor.run {
                reset()
            }
            return
        }
        var id: String? = userToFind
        
        for char in userToFind {
            if !char.isNumber {
                id = await steamNetworkManager.getSteamID(with: userToFind)
                break
            }
        }
        
        guard let id = id, let user = await steamNetworkManager.getUserSummary(id: id) else {
            await MainActor.run {
                reset()
            }
            return
        }
        
        let level = await steamNetworkManager.getLevel(of: id)
        let lastMatchID = await steamNetworkManager.getMatchHistory(steamID: id, amount: 1).first?.matchID
        let lastMatchInfo = lastMatchID != nil ? await steamNetworkManager.getMatchDetails(matchID: lastMatchID!) : nil
        await MainActor.run {
            withAnimation(.spring()) {
                profile = SteamProfile(from: user, level: level)
                lastMatch = lastMatchInfo != nil ? Dota.Match(from: lastMatchInfo!) : nil
            }
        }
    }
    
    func reset() {
        profile = nil
    }
}
