//
//  ComplexNode.swift
//  Round
//
//  Created by Nikita Kazakov on 28.06.2023.
//

import SpriteKit

class SKIlluminatedSpriteNode: SKSpriteNode {
    var parts: [SKNode] {
        get {
            [self, shadow]
        }
    }
    
    override var zPosition: CGFloat {
        get {
            return super.zPosition
        }
        set {
            super.zPosition = newValue
            shadow.zPosition = newValue.shadow
        }
    }
    override var position: CGPoint {
        get {
            return super.position
        }
        set {
            super.position = newValue
            shadow.position = newValue - CGPoint(x: 0, y: self.frame.size.height / sizeMult.height)
        }
    }
    override var texture: SKTexture? {
        get {
            return super.texture
        }
        set {
            super.texture = newValue
            shadow.fillColor = newValue != nil ? .black.withAlphaComponent(0.2) : .clear
        }
    }
    
    private(set) var shadow: SKShapeNode = .init(rect: .zero)
    private(set) var lightSourcePosition: CGPoint = .zero
    private let sizeMult = CGSize(width: 1.2, height: 2.5)
    
    init(withImage image: String, lightSourcePosition: CGPoint = .zero) {
        self.init(imageNamed: image)
        self.lightSourcePosition = lightSourcePosition
        self.shadow = .init(ellipseOf: self.frame.size / CGSize(width: sizeMult.width, height: sizeMult.height))
        self.shadow.position = self.frame.origin - CGPoint(x: 0, y: self.frame.size.height / sizeMult.height)
        self.shadow.fillColor = .black.withAlphaComponent(0.2)
        self.shadow.strokeColor = .clear
    }
    
    init(ofSize size: CGSize) {
        self.init()
        self.lightSourcePosition = .zero
        self.shadow = .init(ellipseOf: size / CGSize(width: sizeMult.width, height: sizeMult.height))
        self.shadow.position = .zero - CGPoint(x: 0, y: size.height / sizeMult.height)
        self.shadow.fillColor = .clear
        self.shadow.strokeColor = .clear
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeFromParent() {
        shadow.removeFromParent()
        super.removeFromParent()
    }
    
    func aspectFitNodeTo(size fitSize: CGSize) {
        aspectFitTo(size: fitSize)
        shadow.aspectFitTo(size: fitSize)
    }
    
    func aspectFillNodeTo(size fitSize: CGSize) {
        aspectFillTo(size: fitSize)
        shadow.aspectFillTo(size: fitSize)
    }
}
