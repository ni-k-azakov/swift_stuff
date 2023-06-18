//
//  Roaster.swift
//  Round
//
//  Created by Nikita Kazakov on 18.06.2023.
//

import Foundation

struct Roaster<T> {
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
    
    func map<Out>(action: @escaping (T) -> Out) -> Roaster<Out> {
        Roaster<Out>(action(first), action(second), action(third), action(fourth))
    }
}
