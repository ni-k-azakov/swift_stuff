//
//  BoardController.swift
//  Round
//
//  Created by Nikita Kazakov on 17.06.2023.
//

import Foundation
import SpriteKit

final class BoardController {
    var tileSize: CGSize!
    var corners: [CGPoint] = []
    var horizontals: [CGPoint] = []
    var verticals: [CGPoint] = []
    var innerField: CGRect!
    var battleField: SKShapeNode!
    
    var tiles: LinkedList<CGPoint>!
    var arenas: LinkedList<Arena>!
    
    func initBattleField() {
        battleField = SKShapeNode(rect: innerField)
        battleField.fillColor = .systemRed
        battleField.zPosition = AppConstants.Priority.BACKGROUND
    }
    
    func initBoard(screenWidth: CGFloat, screenHeight: CGFloat) {
        tileSize = CGSize(width: screenWidth / 4, height: screenWidth / 4)
        
        let verticalTileSize = CGSize(width: screenWidth / 4, height: screenHeight / 5)
        let horizontalTileSize = CGSize(width: screenWidth / 2.5, height: screenWidth / 4)

        innerField = CGRect(
            x: -horizontalTileSize.width / 2,
            y: -verticalTileSize.height,
            width: horizontalTileSize.width,
            height: verticalTileSize.height * 2
        )
        
        corners = [
            CGPoint(
                x: -tileSize.width - horizontalTileSize.width / 2,
                y: verticalTileSize.height
            ),
            CGPoint(
                x: -tileSize.width - horizontalTileSize.width / 2,
                y: -verticalTileSize.height - tileSize.height
            ),
            CGPoint(
                x: horizontalTileSize.width / 2,
                y: -verticalTileSize.height - tileSize.height
            ),
            CGPoint(x: horizontalTileSize.width / 2, y: verticalTileSize.height)
        ]
        
        horizontals = [
            CGPoint(x: -tileSize.width / 2, y: verticalTileSize.height),
            CGPoint(x: -tileSize.width / 2, y: -verticalTileSize.height - tileSize.height)
        ]
        
        verticals = [
            CGPoint(
                x: -tileSize.width - horizontalTileSize.width / 2,
                y: (verticalTileSize.height - tileSize.height) * 2 / 6
            ),
            CGPoint(
                x: -tileSize.width - horizontalTileSize.width / 2,
                y: -(verticalTileSize.height - tileSize.height) * 2 / 6 - tileSize.height
            ),
            CGPoint(
                x: horizontalTileSize.width / 2,
                y: -(verticalTileSize.height - tileSize.height) * 2 / 6 - tileSize.height
            ),
            CGPoint(
                x: horizontalTileSize.width / 2,
                y: (verticalTileSize.height - tileSize.height) * 2 / 6
            )
        ]
    }
    
    func fillTiles() {
        tiles = LinkedList(data: corners[1]).pushBack([
            horizontals[1],
            corners[2],
            verticals[2],
            verticals[3],
            corners[3],
            horizontals[0],
            corners[0],
            verticals[0],
            verticals[1]
        ])
    }
    
    func fillArenas() {
        arenas = LinkedList(data: (
               ArenaManager().generateArena(arenaLevel: 1, enemyLevels: (1, 1, 1, 1))
            )
        ).pushBack([
            ArenaManager().generateArena(arenaLevel: 2, enemyLevels: (1, 1, 1, 1)),
            ArenaManager().generateArena(arenaLevel: 3, enemyLevels: (1, 1, 1, 1)),
            ArenaManager().generateArena(arenaLevel: 4, enemyLevels: (1, 1, 1, 1)),
            ArenaManager().generateArena(arenaLevel: 5, enemyLevels: (1, 1, 1, 1)),
            ArenaManager().generateArena(arenaLevel: 6, enemyLevels: (1, 1, 1, 1)),
            ArenaManager().generateArena(arenaLevel: 7, enemyLevels: (1, 1, 1, 1)),
            ArenaManager().generateArena(arenaLevel: 8, enemyLevels: (1, 1, 1, 1)),
            ArenaManager().generateArena(arenaLevel: 9, enemyLevels: (1, 1, 1, 1)),
            ArenaManager().generateArena(arenaLevel: 10, enemyLevels: (1, 1, 1, 1))
        ])
    }
}
