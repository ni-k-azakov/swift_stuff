import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    static func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        var tempNode = head
        var prevNode: ListNode? = nil
        var prevBase: ListNode? = nil
        var prevPrevBase: ListNode? = nil
        var finalHead: ListNode? = nil
        var nodesAmount = 0
        while let node = tempNode {
            nodesAmount += 1
            tempNode = node.next
        }
        tempNode = head
        for i in 0..<nodesAmount - nodesAmount % k {
            let node = tempNode!
            tempNode = node.next
            if i % k == 0 {
                prevPrevBase = prevBase
                prevBase = node
            } else {
                if i % k == k - 1 {
                    if let unwrapped = prevPrevBase {
                        unwrapped.next = node
                    } else {
                        finalHead = node
                    }
                }
                node.next = prevNode
            }
            prevNode = node
        }
        if nodesAmount % k != 0 {
            prevBase?.next = tempNode
        }
        if let unwrapped = finalHead {
            return unwrapped
        } else {
            return head
        }
    }
}
var node = Solution.reverseKGroup(ListNode(1, ListNode(2)), 2)
while let _ = node {
    print(node!.val)
    node = node!.next
}
