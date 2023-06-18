//
//  NetworkManager.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 13.04.2023.
//

import Foundation

protocol NetworkManager {
    var root: String { get }
}

extension NetworkManager {
    func getError(error: Error, url: URL) -> String {
        "[\n Error: \(root)\n \(error)\n \(url)\n]"
    }
    
    func getURL(endPoint: String) -> URL? {
        URL(string: "\(root)/\(endPoint)")
    }
}
