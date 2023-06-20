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
    var configs: LinkedList<ArenaConfig>!
    var nodes: LinkedList<SKShapeNode>!
    
    var enemyRoster: Roster<SKSpriteNode?> = Roster(nil, nil, nil, nil)
    
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
        fillConfigs()
        updateArenas()
        buildNodes()
    }
}

extension BoardController {
    func update() {
        var node: Node<SKShapeNode>? = nodes.root
        var arenaNode: Node<Arena>? = arenas.root
        while let unwrapped = node, let arena = arenaNode  {
            updateNode(unwrapped.data, with: arena.data)
            node = unwrapped.next
            arenaNode = arena.next
        }
    }
    
    func setSpawnBoxes(in root: CGRect) {
        arenaManager.setSpawnBoxes(
            Roster(
                root * CGSize(width: 0.5, height: 2 / 3) + CGPoint(x: root.width / 4, y: 0),
                root * CGSize(width: 0.5, height: 1 / 3) + CGPoint(x: root.width / 4, y: root.height * 2 / 3),
                root / CGSize(width: 4, height: 1),
                root / CGSize(width: 4, height: 1) + CGPoint(x: root.width * 3 / 4, y: 0)
            )
        )
        
        updateArenas()
    }
    
    func updateRoster() {
        enemyRoster.forEach { $0?.removeFromParent() }
        arenas.bookmark.data.updateRoster()
        enemyRoster = arenas.bookmark.data.roster.map { [weak self] in
            guard let enemyInfo = $0, let self else { return nil }
            return createEnemy(enemy: enemyInfo.0, at: enemyInfo.1, ofSize: self.tileSize / 1.5)
        }
        setEnemiesPerspective()
    }
    
    func wipeEnemies() {
        arenas.bookmark.data.wipeEnemies()
    }
    
    func buildNode(tile: CGPoint, arena: Arena) -> SKShapeNode {
        let tileNode = SKShapeNode(rect: CGRect(origin: tile, size: tileSize))
        if arena.roster.first != nil || arena.roster.second != nil || arena.roster.third != nil || arena.roster.fourth != nil {
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
    
    func updateNode(_ node: SKShapeNode, with arena: Arena) {
        if arena.roster.first != nil || arena.roster.second != nil || arena.roster.third != nil || arena.roster.fourth != nil {
            node.fillColor = .systemGreen
        } else {
            node.fillColor = .systemRed
        }
    }
    
    func rebuildCurrentNode() -> SKShapeNode {
        nodes.updateBookmarked(with: buildNode(tile: tiles.bookmark.data, arena: arenas.bookmark.data))
    }
    
    func redrawCurrentNode() {
        updateNode(nodes.bookmark.data, with: arenas.bookmark.data)
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
    
    func updateArenas() {
        configs.resetBookmark()
        arenas = LinkedList(
            data: [
                arenaManager.generateArenaFrom(config: configs.root.data),
                arenaManager.generateArenaFrom(config: configs.moveBookmark()),
                arenaManager.generateArenaFrom(config: configs.moveBookmark()),
                arenaManager.generateArenaFrom(config: configs.moveBookmark()),
                arenaManager.generateArenaFrom(config: configs.moveBookmark()),
                arenaManager.generateArenaFrom(config: configs.moveBookmark()),
                arenaManager.generateArenaFrom(config: configs.moveBookmark()),
                arenaManager.generateArenaFrom(config: configs.moveBookmark()),
                arenaManager.generateArenaFrom(config: configs.moveBookmark()),
                arenaManager.generateArenaFrom(config: configs.moveBookmark())
            ]
        )
    }
    
    @discardableResult func move() -> Self {
        tiles.moveBookmark()
        arenas.moveBookmark()
        nodes.moveBookmark()
        return self
    }

    private func fillTiles() {
        tiles = LinkedList(data: [
            corners[1],
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
    
    private func fillConfigs() {
        configs = LinkedList(
            data: [
                ArenaConfig(level: 1, enemyLevels: Roster(nil, nil, nil, nil)),
                ArenaConfig(level: 2, enemyLevels: Roster(1, 1, 1, 1)),
                ArenaConfig(level: 3, enemyLevels: Roster(1, 2, 0, 1)),
                ArenaConfig(level: 4, enemyLevels: Roster(0, 0, 2, 0)),
                ArenaConfig(level: 5, enemyLevels: Roster(2, 2, 2, 2)),
                ArenaConfig(level: 6, enemyLevels: Roster(1, 1, 1, 1)),
                ArenaConfig(level: 7, enemyLevels: Roster(0, 1, 1, 1)),
                ArenaConfig(level: 8, enemyLevels: Roster(1, 0, 0, 2)),
                ArenaConfig(level: 9, enemyLevels: Roster(1, 0, 1, 2)),
                ArenaConfig(level: 10, enemyLevels: Roster(1, 2, 2, 1))
            ]
        )
    }
    
    private func createEnemy(enemy: Enemy, at point: CGPoint, ofSize size: CGSize) -> SKSpriteNode {
        let enemySprite = SKSpriteNode(imageNamed: enemy.image)
        enemySprite.position = point
        enemySprite.zPosition = AppConstants.Priority.ENEMY
        enemySprite.aspectFitTo(size: size)
        return enemySprite
    }
    
    private func setEnemiesPerspective() {
        enemyRoster.forEach { [weak self] enemy, index in
            guard let enemy, let self else { return }
            enemy.zPosition = AppConstants.Priority.ENEMY.moveFront(
                UInt(self.enemyRoster.countIf { (enemy.frame.minY) < ($0?.frame.minY ?? 0) })
            )
        }
    }
}
