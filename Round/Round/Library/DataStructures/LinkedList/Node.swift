//
//  Node.swift
//  Round
//
//  Created by Nikita Kazakov on 16.06.2023.
//

import Foundation

class Node<T> {
    var data: T
    var next: Node?
    
    init(data: T, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}
