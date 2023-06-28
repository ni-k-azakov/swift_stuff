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
        let horizontalRatio = fillSize.width / texture.size().width
        let ratio = horizontalRatio > verticalRatio ? horizontalRatio : verticalRatio
        self.scale(to: CGSize(width: size.width * ratio, height: size.height * ratio))
    }
    
    func aspectFitTo(size fitSize: CGSize) {
        guard let texture else { return }
        
        self.size = texture.size()
        
        let verticalRatio = fitSize.height / texture.size().height
        let horizontalRatio = fitSize.width / texture.size().width
        let ratio = horizontalRatio > verticalRatio ? verticalRatio : horizontalRatio
        self.scale(to: CGSize(width: size.width * ratio, height: size.height * ratio))
    }
}
