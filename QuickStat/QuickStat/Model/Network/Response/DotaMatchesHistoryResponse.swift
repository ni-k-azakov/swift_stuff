//
//  DotaMatchesHistoryResponse.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 27.04.2023.
//

import Foundation

struct DotaMatchesHistoryResponse: Decodable {
    let result: Response
    
    struct Response: Decodable {
        let status: Int
        let amount: Int
        let totalResults: Int
        let resultsRemaining: Int
        let matches: [DotaMatchOverviewDTO]
        
        enum CodingKeys: String, CodingKey {
            case amount = "num_results"
            case totalResults = "total_results"
            case resultsRemaining = "results_remaining"
            case status, matches
        }
    }
}
