//
//  SKShapeNode.swift
//  Round
//
//  Created by Nikita Kazakov on 24.06.2023.
//

import SpriteKit

extension SKShapeNode {
    func aspectFillTo(size fillSize: CGSize) {
        let verticalRatio = fillSize.height / self.frame.size.height
        let horizontalRatio = fillSize.width / self.frame.size.width
        let ratio = horizontalRatio > verticalRatio ? horizontalRatio : verticalRatio
        
        self.setScale(ratio)
    }
    
    func aspectFitTo(size fitSize: CGSize) {
        let verticalRatio = fitSize.height / self.frame.size.height
        let horizontalRatio = fitSize.width / self.frame.size.width
        let ratio = horizontalRatio > verticalRatio ? verticalRatio : horizontalRatio
        
        self.setScale(ratio)
    }
}
