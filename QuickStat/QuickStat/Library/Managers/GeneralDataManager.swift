//
//  GeneralDataManager.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 29.04.2023.
//

import Foundation

final class GeneralDataManager: ObservableObject {
    private var heroList: [Dota.Hero]
    
    init() {
        if let storedHeroes: [Dota.Hero] = StoredHeroesProvider.shared.fetchStoredData(), !storedHeroes.isEmpty {
            self.heroList = storedHeroes
        } else {
            self.heroList = []
            Task {
                let heroes = await SteamNetworkManager().getHeroesList()
                
                await MainActor.run {
                    for hero in heroes {
                        heroList.append(Dota.Hero(from: hero))
                    }
                    StoredHeroesProvider.shared.updateStoredData(with: heroList)
                }
            }
        }
    }
    
    func getHero(withID id: Int) -> Dota.Hero? {
        heroList.first { $0.id == id }
    }
}
