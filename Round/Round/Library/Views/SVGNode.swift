//
//  SVGNode.swift
//  Round
//
//  Created by Nikita Kazakov on 23.06.2023.
//

//import Foundation
//import SpriteKit
//import PocketSVG
//
//class SVGNode: SKShapeNode {
//    var shapes: [SKShapeNode] = []
//    var resource: String {
//        get {
//            _resource
//        }
//        set {
//            _resource = newValue
//            loadSVG(withName: _resource)
//        }
//    }
//    
//    private var _resource: String = ""
//    private var _frame: CGRect? = nil
//    
//    init(fileName: String) {
//        super.init()
//        loadSVG(withName: fileName)
//    }
//    
//    init(fileName: String, in frame: CGRect? = nil) {
//        super.init()
//        _frame = frame
//        loadSVG(withName: fileName)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func removeFromParent() {
//        removeCurrentSVG()
//        super.removeFromParent()
//    }
//    
//    func set(_ frame: CGRect?) {
//        _frame = frame
//        loadSVG(withName: _resource)
//    }
//    
//    private func loadSVG(withName name: String) {
//        removeCurrentSVG()
//        
//        let resource = Bundle.main.url(forResource: name, withExtension: "svg")
//        guard let resource else { return }
//
//        let paths = SVGBezierPath.pathsFromSVG(at: resource)
//        for (index, path) in paths.enumerated() {
//            let node = {
//                let node = SKShapeNode(path: path.cgPath)
//                node.path = path.cgPath
////                if let _frame { node.aspectFitTo(size: _frame.size) }
//                if index % 2 == 0 {
//                    node.fillColor = .black
//                } else {
//                    node.fillColor = .gray
//                }
//                self.position = .init(x: -200, y: -200)
////                if let _frame { node.position = _frame.origin }
//                return node
//            }()
//            shapes.append(node)
//            self.addChild(node)
//        }
//    }
//    
//    private func removeCurrentSVG() {
//        for shape in shapes {
//            shape.removeFromParent()
//        }
//        shapes = []
//    }
//}
