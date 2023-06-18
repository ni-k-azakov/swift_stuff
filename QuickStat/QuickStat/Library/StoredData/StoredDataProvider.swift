//
//  StoredDataProvider.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 28.04.2023.
//

import Foundation

class StoredDataProvider {
    let filename: String
    let dataType: String
    let manager = FileManager.default
    
    init(filename: String, dataType: String) {
        self.filename = filename
        self.dataType = dataType
    }
    
    private var storedDataPath: URL? {
        manager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )
        .first?
        .appendingPathComponent(filename)
        .appendingPathExtension(dataType)
    }
    
    func fetchStoredData<T: Decodable>() -> T? {
        guard let storedDataPath else { return nil }
        do {
            let data = try Data(contentsOf: storedDataPath)
            let storedData = try JSONDecoder().decode(T.self, from: data)
            return storedData
        } catch {
            return nil
        }
    }
    
    func updateStoredData(with data: Codable) {
        guard let storedDataPath else { return }
        if let data = try? JSONEncoder().encode(data) {
            try? data.write(to: storedDataPath, options: [.atomicWrite])
        }
    }
}
