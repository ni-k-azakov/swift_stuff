//
//  BoardController.swift
//  Round
//
//  Created by Nikita Kazakov on 17.06.2023.
//

import Foundation
import SpriteKit


final class BoardController {
    let arenaManager = ArenaManager()
    
    var tileSize: CGSize!
    var innerField: CGRect!
    var battleField: SKShapeNode!
    
    var corners: [CGPoint] = []
    var horizontals: [CGPoint] = []
    var verticals: [CGPoint] = []
    
    
    var tiles: LinkedList<CGPoint>!
    var arenas: LinkedList<Arena>!
    var nodes: LinkedList<SKShapeNode>!
    
    var enemyRoaster: Roaster<SKSpriteNode?> = Roaster(nil, nil, nil, nil)
    
    init(screenWidth: CGFloat, screenHeight: CGFloat) {
        initBoard(screenWidth: screenWidth, screenHeight: screenHeight)
        initBattleField()
    }
    
    private func initBattleField() {
        battleField = SKShapeNode(rect: innerField)
        battleField.fillColor = .systemRed
        battleField.zPosition = AppConstants.Priority.BACKGROUND
    }
    
    private func initBoard(screenWidth: CGFloat, screenHeight: CGFloat) {
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
        
        fillTiles()
        updateArenas()
        buildNodes()
    }
}

extension BoardController {
    func setSpawnBoxes(in root: CGRect) {
        arenaManager.setSpawnBoxes(
            Roaster(
                root * CGSize(width: 0.5, height: 2 / 3) + CGPoint(x: root.width / 4, y: 0),
                root * CGSize(width: 0.5, height: 1 / 3) + CGPoint(x: root.width / 4, y: root.height * 2 / 3),
                root / CGSize(width: 4, height: 1),
                root / CGSize(width: 4, height: 1) + CGPoint(x: root.width * 3 / 4, y: 0)
            )
        )
        
        updateArenas()
    }
    
    func updateRoaster() {
        enemyRoaster.forEach { $0?.removeFromParent() }
        arenas.bookmark.data.updateRoaster()
        enemyRoaster = arenas.bookmark.data.roaster.map { [weak self] in
            guard let enemyInfo = $0, let self else { return nil }
            return createEnemy(enemy: enemyInfo.0, at: enemyInfo.1, ofSize: self.tileSize / 1.5)
        }
        setEnemiesPerspective()
    }
    
    func dealDamage(_ damage: UInt) {
        arenas.bookmark.data.dealDamage(damage: damage)
    }
    
    func buildNode(tile: CGPoint, arena: Arena) -> SKShapeNode {
        let tileNode = SKShapeNode(rect: CGRect(origin: tile, size: tileSize))
        if arena.roaster.first != nil || arena.roaster.second != nil || arena.roaster.third != nil || arena.roaster.fourth != nil {
            tileNode.fillColor = .systemGreen
        } else {
            tileNode.fillColor = .systemRed
        }
        
        tileNode.zPosition = AppConstants.Priority.GROUND
        
        let label = SKLabelNode(text: "\(arena.background)")
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.position = tileNode.frame.center
        tileNode.addChild(label)
        
        return tileNode
    }
    
    func rebuildCurrentNode() -> SKShapeNode {
        nodes.updateBookmarked(with: buildNode(tile: tiles.bookmark.data, arena: arenas.bookmark.data))
    }
    
    func buildNodes() {
        var newNodes: [SKShapeNode] = []
        
        var unsafeArena: Node? = arenas.root
        var unsafeTile: Node? = tiles.root
        
        while let safeArena = unsafeArena, let safeTile = unsafeTile {
            let arenaData = safeArena.data
            let tileData = safeTile.data
            newNodes.append(buildNode(tile: tileData, arena: arenaData))
            unsafeArena = safeArena.next
            unsafeTile = safeTile.next
        }
        
        nodes = LinkedList(data: newNodes)
    }
    
    private func fillTiles() {
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
    
    private func updateArenas() {
        arenas = LinkedList(data: (
               arenaManager.generateArena(arenaLevel: 1)
            )
        ).pushBack([
            arenaManager.generateArena(arenaLevel: 2),
            arenaManager.generateArena(arenaLevel: 3),
            arenaManager.generateArena(arenaLevel: 4),
            arenaManager.generateArena(arenaLevel: 5),
            arenaManager.generateArena(arenaLevel: 6),
            arenaManager.generateArena(arenaLevel: 7),
            arenaManager.generateArena(arenaLevel: 8),
            arenaManager.generateArena(arenaLevel: 9),
            arenaManager.generateArena(arenaLevel: 10)
        ])
    }
    
    private func createEnemy(enemy: Enemy, at point: CGPoint, ofSize size: CGSize) -> SKSpriteNode {
        let enemySprite = SKSpriteNode(imageNamed: enemy.image)
        enemySprite.position = point
        enemySprite.zPosition = AppConstants.Priority.ENEMY
        enemySprite.aspectFitTo(size: size)
        return enemySprite
    }
    
    private func setEnemiesPerspective() {
        let roasterSequence = [enemyRoaster[0], enemyRoaster[1], enemyRoaster[2], enemyRoaster[3]]
        
        enemyRoaster.forEach { enemy, index in
            guard let enemy else { return }
            enemy.zPosition = AppConstants.Priority.ENEMY.moveFront(
                UInt(roasterSequence.filter { (enemy.frame.minY) > ($0?.frame.minY ?? 0) }.count)
            )
        }
    }
}
