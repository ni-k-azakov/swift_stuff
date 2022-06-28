//
//  D.swift
//  Contests
//
//  Created by Nikita Kazakov on 26.04.2022.
//

//public struct PriorityQueue<T: Comparable> {
//    
//    fileprivate var heap = [T]()
//    private let ordered: (T, T) -> Bool
//    
//    public init(ascending: Bool = false, startingValues: [T] = []) {
//        self.init(order: ascending ? { $0 > $1 } : { $0 < $1 }, startingValues: startingValues)
//    }
//    
//    public init(order: @escaping (T, T) -> Bool, startingValues: [T] = []) {
//        ordered = order
//        heap = startingValues
//        var i = heap.count/2 - 1
//        while i >= 0 {
//            sink(i)
//            i -= 1
//        }
//    }
//    
//    public var count: Int { return heap.count }
//    
//    public var isEmpty: Bool { return heap.isEmpty }
//    
//    public mutating func push(_ element: T) {
//        heap.append(element)
//        swim(heap.count - 1)
//    }
//    
//    public mutating func pop() -> T? {
//        if heap.isEmpty { return nil }
//        let count = heap.count
//        if count == 1 { return heap.removeFirst() }
//        fastPop(newCount: count - 1)
//        
//        return heap.removeLast()
//    }
//    
//    public mutating func remove(_ item: T) {
//        if let index = heap.firstIndex(of: item) {
//            heap.swapAt(index, heap.count - 1)
//            heap.removeLast()
//            if index < heap.count {
//                swim(index)
//                sink(index)
//            }
//        }
//    }
//    
//    public mutating func removeAll(_ item: T) {
//        var lastCount = heap.count
//        remove(item)
//        while (heap.count < lastCount) {
//            lastCount = heap.count
//            remove(item)
//        }
//    }
//    
//    public func peek() -> T? {
//        return heap.first
//    }
//    
//    public mutating func clear() {
//        heap.removeAll(keepingCapacity: false)
//    }
//    
//    private mutating func sink(_ index: Int) {
//        var index = index
//        while 2 * index + 1 < heap.count {
//            
//            var j = 2 * index + 1
//            
//            if j < (heap.count - 1) && ordered(heap[j], heap[j + 1]) { j += 1 }
//            if !ordered(heap[index], heap[j]) { break }
//            
//            heap.swapAt(index, j)
//            index = j
//        }
//    }
//    
//    private mutating func fastPop(newCount: Int) {
//        var index = 0
//        heap.withUnsafeMutableBufferPointer { bufferPointer in
//            let _heap = bufferPointer.baseAddress! // guaranteed non-nil because count > 0
//            swap(&_heap[0], &_heap[newCount])
//            while 2 * index + 1 < newCount {
//                var j = 2 * index + 1
//                if j < (newCount - 1) && ordered(_heap[j], _heap[j+1]) { j += 1 }
//                if !ordered(_heap[index], _heap[j]) { return }
//                swap(&_heap[index], &_heap[j])
//                index = j
//            }
//        }
//    }
//    
//    private mutating func swim(_ index: Int) {
//        var index = index
//        while index > 0 && ordered(heap[(index - 1) / 2], heap[index]) {
//            heap.swapAt((index - 1) / 2, index)
//            index = (index - 1) / 2
//        }
//    }
//}
//
//extension PriorityQueue: IteratorProtocol {
//    
//    public typealias Element = T
//    mutating public func next() -> Element? { return pop() }
//}
//
//extension PriorityQueue: Sequence {
//    
//    public typealias Iterator = PriorityQueue
//    public func makeIterator() -> Iterator { return self }
//}
//
//extension PriorityQueue: Collection {
//    
//    public typealias Index = Int
//    
//    public var startIndex: Int { return heap.startIndex }
//    public var endIndex: Int { return heap.endIndex }
//    
//    public subscript(i: Int) -> T { return heap[i] }
//    
//    public func index(after i: PriorityQueue.Index) -> PriorityQueue.Index {
//        return heap.index(after: i)
//    }
//}
//
//import Foundation
//
//enum Side {
//    case E
//    case N
//    case S
//    case W
//}
//
//class Node {
//    var isObstackle: Bool
//    var path: Int
//    var from: Side
//
//    init(value: Int) {
//        if value == 1 {
//            isObstackle = true
//        } else {
//            isObstackle = false
//        }
//        path = -1
//        from = Side.N
//    }
//}
//
//class Note: Comparable {
//    var i: Int
//    var j: Int
//    var from: Side
//    var prev: Node
//    var distance: Int
//    
//    init(_ i: Int, _ j: Int, _ from: Side, _ prev: Node, _ distance: Int) {
//        self.i = i
//        self.j = j
//        self.from = from
//        self.prev = prev
//        self.distance = distance
//    }
//}
//
//func >(left: Note, right: Note) -> Bool {
//    return left.distance > right.distance
//}
//
//func <(left: Note, right: Note) -> Bool {
//    return left.distance < right.distance
//}
//
//func ==(left: Note, right: Note) -> Bool {
//    return left.distance == right.distance
//}
//
//let NM = readLine()!.split(separator: " ")
//let N = Int(NM[0])!
//let M = Int(NM[1])!
//
//let coord = readLine()!.split(separator: " ")
//let start_y = Int(coord[0])!
//let start_x = Int(coord[1])!
//let finish_y = Int(coord[2])!
//let finish_x = Int(coord[3])!
//
//var field: [[Node]] = []
//for _ in 0..<N {
//    let input = readLine()!.split(separator: " ")
//    field.append(input.compactMap({ Node(value: Int($0)!) }))
//}
//var queue = PriorityQueue(ascending: true, startingValues: [Note(start_y, start_x, Side.N, Node(value: 0), (finish_y - start_y) * (finish_y - start_y) + (finish_x - start_x) * (finish_x - start_x))])
//field[start_y][start_x].path = 1
//while let currentNodeInfo = queue.pop() {
//    let currentNode = field[currentNodeInfo.i][currentNodeInfo.j]
//    let prevNode = currentNodeInfo.prev
////    print()
////    print(currentNodeInfo.i, currentNodeInfo.j)
//    if currentNode.isObstackle {
//        continue
//    }
//    if prevNode.path + 1 < currentNode.path || currentNode.path == -1 {
//        currentNode.path = prevNode.path + 1
//        currentNode.from = currentNodeInfo.from
//        if currentNodeInfo.i == finish_y && currentNodeInfo.j == finish_x {
//            break
//        }
//        var i = (currentNodeInfo.i + 1) % N
//        var xDist = finish_y - i
//        if xDist * xDist > (N - 1 - i + finish_y) * (N - 1 - i + finish_y) {
//            xDist = N - 1 - i + finish_y
//        }
//        if xDist * xDist > (i + N - 1 - finish_y) * (i + N - 1 - finish_y) {
//            xDist = i + N - 1 - finish_y
//        }
//        var j = currentNodeInfo.j
//        var yDist = finish_x - j
//        if yDist * yDist > (M - 1 - j + finish_x) * (M - 1 - j + finish_x) {
//            yDist = M - 1 - j + finish_x
//        }
//        if yDist * yDist > (j + M - 1 - finish_x) * (j + M - 1 - finish_x) {
//            yDist = j + M - 1 - finish_x
//        }
//        queue.push(Note(i, j, Side.S, currentNode, xDist * xDist + yDist * yDist))
////        print(i, j, xDist * xDist + yDist * yDist)
//        i = currentNodeInfo.i
//        xDist = finish_y - i
//        if xDist * xDist > (N - 1 - i + finish_y) * (N - 1 - i + finish_y) {
//            xDist = N - 1 - i + finish_y
//        }
//        if xDist * xDist > (i + N - 1 - finish_y) * (i + N - 1 - finish_y) {
//            xDist = i + N - 1 - finish_y
//        }
//        j = (currentNodeInfo.j + 1) % M
//        yDist = finish_x - j
//        if yDist * yDist > (M - 1 - j + finish_x) * (M - 1 - j + finish_x) {
//            yDist = M - 1 - j + finish_x
//        }
//        if yDist * yDist > (j + M - 1 - finish_x) * (j + M - 1 - finish_x) {
//            yDist = j + M - 1 - finish_x
//        }
//        queue.push(Note(i, j, Side.E, currentNode, xDist * xDist + yDist * yDist))
////        print(i, j, xDist * xDist + yDist * yDist)
//        i = (currentNodeInfo.i - 1 + N) % N
//        xDist = finish_y - i
//        if xDist * xDist > (N - 1 - i + finish_y) * (N - 1 - i + finish_y) {
//            xDist = N - 1 - i + finish_y
//        }
//        if xDist * xDist > (i + N - 1 - finish_y) * (i + N - 1 - finish_y) {
//            xDist = i + N - 1 - finish_y
//        }
//        j = currentNodeInfo.j
//        yDist = finish_x - j
//        if yDist * yDist > (M - 1 - j + finish_x) * (M - 1 - j + finish_x) {
//            yDist = M - 1 - j + finish_x
//        }
//        if yDist * yDist > (j + M - 1 - finish_x) * (j + M - 1 - finish_x) {
//            yDist = j + M - 1 - finish_x
//        }
//        queue.push(Note(i, j, Side.N, currentNode, xDist * xDist + yDist * yDist))
////        print(i, j, xDist * xDist + yDist * yDist)
//        i = currentNodeInfo.i
//        xDist = finish_y - i
//        if xDist * xDist > (N - 1 - i + finish_y) * (N - 1 - i + finish_y) {
//            xDist = N - 1 - i + finish_y
//        }
//        if xDist * xDist > (i + N - 1 - finish_y) * (i + N - 1 - finish_y) {
//            xDist = i + N - 1 - finish_y
//        }
//        j = (currentNodeInfo.j - 1 + M) % M
//        yDist = finish_x - j
//        if yDist * yDist > (M - 1 - j + finish_x) * (M - 1 - j + finish_x) {
//            yDist = M - 1 - j + finish_x
//        }
//        if yDist * yDist > (j + M - 1 - finish_x) * (j + M - 1 - finish_x) {
//            yDist = j + M - 1 - finish_x
//        }
//        queue.push(Note(i, j, Side.W, currentNode, xDist * xDist + yDist * yDist))
////        print(i, j, xDist * xDist + yDist * yDist)
//    }
//}
//var i = finish_y
//var j = finish_x
//var current = field[i][j]
//var answer = ""
//if current.path != -1 {
//    while current.path != 0 {
//        switch current.from {
//        case .N:
//            i += 1
//            i %= N
//            answer += "N"
//        case .E:
//            j -= 1
//            j += M
//            j %= M
//            answer += "E"
//        case .W:
//            j += 1
//            j %= M
//            answer += "W"
//        case .S:
//            i -= 1
//            i += N
//            i %= N
//            answer += "S"
//        }
//        current = field[i][j]
//    }
//    print(String(answer.reversed()))
//} else {
//    print(-1)
//}


