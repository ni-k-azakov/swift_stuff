//
//  ParallelFetcher.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 04.06.2023.
//

import Foundation

final class ParallelAsyncFetcher<Argument, Result> {
    private var args: [Argument] = []
    private let onFetch: (Argument) async -> Result?
    
    init (onFetch: @escaping (Argument) async -> Result?) {
        self.onFetch = onFetch
    }
    
    func setArguments(_ arguments: [Argument]) -> Self {
        self.args = arguments
        return self
    }
    
    func fetch() async -> [Result] {
        var result: [Result?] = []
        await withTaskGroup(of: Result?.self) { group in
            for arg in args {
                group.addTask { await self.onFetch(arg) }
            }
            
            for await data in group {
                result.append(data)
            }
        }
        return result.compactMap{ $0 }
    }
}
