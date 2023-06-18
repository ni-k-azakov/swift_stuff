//
//  StoredSteamProfilesProvider.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 28.04.2023.
//

import Foundation

final class StoredSteamProfilesProvider: StoredDataProvider {
    static let shared = StoredSteamProfilesProvider(
        filename: ApplicationConstants.steamProfiles,
        dataType: "json"
    )
    
    override private init(filename: String, dataType: String) {
        super.init(filename: filename, dataType: dataType)
    }
}
