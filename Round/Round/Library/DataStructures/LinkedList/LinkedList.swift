//
//  LinkedList.swift
//  Round
//
//  Created by Nikita Kazakov on 16.06.2023.
//

import Foundation

class LinkedList<T> {
    var first: T { root.data }
    var last: T { tail.data }
    
    private(set) var root: Node<T>
    private(set) var tail: Node<T>
    private(set) var bookmark: Node<T>
    
    init(data: T) {
        let node = Node(data: data)
        self.root = node
        self.tail = node
        self.bookmark = node
    }
    
    @discardableResult func pushBack(_ data: T) -> Self {
        let node = Node(data: data)
        tail.next = node
        tail = node
        return self
    }
    
    @discardableResult func pushBack(_ elements: [T]) -> Self {
        for data in elements {
            let node = Node(data: data)
            tail.next = node
            tail = node
        }
        return self
    }
    
    @discardableResult func pushFront(_ data: T) -> Self {
        let node = Node(data: data)
        node.next = root
        root = node
        return self
    }
    
    @discardableResult func moveBookmark() -> T {
        if let next = bookmark.next {
            bookmark = next
        } else {
            bookmark = root
        }
        return bookmark.data
    }
}
