//import Foundation
//
//class Node {
//    var subNodes: [Node] = []
//    var subRating = 0
//    var mark: Int
//    var money: Int
//    init (_ mark: Int) {
//        self.mark = mark
//        self.money = 0
//    }
//
//    func giveMoney() {
//        for node in subNodes {
//            node.money = money * node.mark / subRating
//            node.giveMoney()
//        }
//    }
//
//    func addChild(_ node: Node) {
//        subRating += node.mark
//        subNodes.append(node)
//    }
//}
//
//var nodes: [Node] = []
//
//let input = readLine()!.split(separator: " ")
//let n = Int(input[0])!
//
//var rootNode = Node(0)
//rootNode.money = Int(input[1])!
//nodes.append(rootNode)
//
//let input2 = readLine()!.split(separator: " ")
//let input3 = readLine()!.split(separator: " ")
//
//for i in 0..<n {
//    nodes.append(Node(Int(input2[i])!))
//}
//
//for i in 1...n {
//    nodes[Int(input3[i - 1])!].addChild(nodes[i])
//}
//
//rootNode.giveMoney()
//
//var output = ""
//for i in 1...n {
//    output += "\(nodes[i].money) "
//}
//
//print(output)
