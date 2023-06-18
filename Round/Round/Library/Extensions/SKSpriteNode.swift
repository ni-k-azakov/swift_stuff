//
//  SKSpriteNode.swift
//  Round
//
//  Created by Nikita Kazakov on 16.06.2023.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    func aspectFillTo(size fillSize: CGSize) {
        guard let texture else { return }
        
        self.size = texture.size()

        let verticalRatio = fillSize.height / texture.size().height
        let horizontalRatio = fillSize.width /  texture.size().width

        self.setScale(horizontalRatio > verticalRatio ? horizontalRatio : verticalRatio)
    }
    
    func aspectFitTo(size fillSize: CGSize) {
        guard let texture else { return }
        
        self.size = texture.size()

        let verticalRatio = fillSize.height / texture.size().height
        let horizontalRatio = fillSize.width /  texture.size().width

        self.setScale(horizontalRatio > verticalRatio ? verticalRatio : horizontalRatio)
    }
}
