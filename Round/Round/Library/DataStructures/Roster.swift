//
//  Roster.swift
//  Round
//
//  Created by Nikita Kazakov on 18.06.2023.
//

import Foundation

struct Roster<T> {
    var first: T
    var second: T
    var third: T
    var fourth: T
    
    init(_ first: T, _ second: T, _ third: T, _ fourth: T) {
        self.first = first
        self.second = second
        self.third = third
        self.fourth = fourth
    }
    
    subscript(index: Int) -> T {
        get {
            let index = index % 4
            
            if index == 0 { return first }
            if index == 1 { return second }
            if index == 2 { return third }
            if index == 3 { return fourth }
            
            return first
        }
        
        set(newVal) {
            let index = index % 4
            
            if index == 0 { first = newVal }
            if index == 1 { second = newVal }
            if index == 2 { third = newVal }
            if index == 3 { fourth = newVal }
        }
    }
    
    func forEach(action: @escaping (T, Int) -> Void) {
        action(first, 0)
        action(second, 1)
        action(third, 2)
        action(fourth, 3)
    }
    
    func forEach(action: @escaping (T) -> Void) {
        action(first)
        action(second)
        action(third)
        action(fourth)
    }
    
    func countIf(action: @escaping (T) -> Bool) -> Int {
        var amount = 0
        amount += action(first) ? 1 : 0
        amount += action(second) ? 1 : 0
        amount += action(third) ? 1 : 0
        amount += action(fourth) ? 1 : 0
        return amount
    }
    
    func countIf(action: @escaping (T, Int) -> Bool) -> Int {
        var amount = 0
        amount += action(first, 0) ? 1 : 0
        amount += action(second, 1) ? 1 : 0
        amount += action(third, 2) ? 1 : 0
        amount += action(fourth, 3) ? 1 : 0
        return amount
    }
    
    func map<Out>(action: @escaping (T) -> Out) -> Roster<Out> {
        Roster<Out>(action(first), action(second), action(third), action(fourth))
    }
    
    func map<Out>(action: @escaping (T, Int) -> Out) -> Roster<Out> {
        Roster<Out>(action(first, 0), action(second, 1), action(third, 2), action(fourth, 3))
    }
    
    func max<Out>(_ keyPath: KeyPath<T, Out>) -> Out where Out: Comparable {
        return Swift.max(first[keyPath: keyPath], second[keyPath: keyPath], third[keyPath: keyPath], fourth[keyPath: keyPath])
    }
    
    func sum<Out>(action: @escaping (T) -> Out) -> Out where Out: Numeric {
        return action(first) + action(second) + action(third) + action(fourth)
    }
}
