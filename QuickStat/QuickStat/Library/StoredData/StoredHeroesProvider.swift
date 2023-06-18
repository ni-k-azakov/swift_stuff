//
//  StoredHeroesProvider.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 29.04.2023.
//

import Foundation

final class StoredHeroesProvider: StoredDataProvider {
    static let shared = StoredDataProvider(
        filename: ApplicationConstants.dotaHeroes,
        dataType: "json"
    )
    
    override private init(filename: String, dataType: String) {
        super.init(filename: filename, dataType: dataType)
    }
}
