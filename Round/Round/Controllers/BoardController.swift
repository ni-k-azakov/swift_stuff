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
    var battleField: SKSpriteNode!
    
    var tiles: LinkedList<CGPoint>!
    var arenas: LinkedList<Arena>!
    var configs: LinkedList<ArenaConfig>!
    var nodes: LinkedList<SKSpriteNode>!
    
    var enemyRoster: Roster<SKIlluminatedSpriteNode>!
    
    var currentRunNetworth: Double = 0
    
    private weak var sceneDelegate: SceneDelegate?
    private var corners: [CGPoint] = []
    private var horizontals: [CGPoint] = []
    private var verticals: [CGPoint] = []
    
    init(delegate: SceneDelegate? = nil) {
        self.sceneDelegate = delegate
    }
    
    func build() {
        initBoard()
        initBattleField()
        initEnemyRoster()
    }
    
    private func initBattleField() {
        battleField = SKSpriteNode(imageNamed: "field")
        battleField.position = innerField.center
        battleField.size = innerField.size
        battleField.zPosition = AppConstants.Priority.BACKGROUND
        sceneDelegate?.addChild(battleField)
    }
    
    private func initBoard() {
        let screenWidth = sceneDelegate?.screenSize.width ?? 0
        let screenHeight = sceneDelegate?.screenSize.height ?? 0
        
        self.tileSize = CGSize(width: screenWidth / 4, height: screenWidth / 4)
        
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
                x: -(tileSize + horizontalTileSize).width / 2,
                y: (verticalTileSize + tileSize / 2).height
            ),
            CGPoint(
                x: -(tileSize + horizontalTileSize).width / 2,
                y: -(verticalTileSize + tileSize / 2).height
            ),
            CGPoint(
                x: (horizontalTileSize + tileSize).width / 2,
                y: -(verticalTileSize + tileSize / 2).height
            ),
            CGPoint(
                x: (horizontalTileSize + tileSize).width / 2,
                y: (verticalTileSize + tileSize / 2).height
            )
        ]
        
        horizontals = [
            CGPoint(x: 0, y: (verticalTileSize + tileSize / 2).height),
            CGPoint(x: 0, y: -(verticalTileSize + tileSize / 2).height)
        ]
        
        let vertY = (verticalTileSize - tileSize).height * 2 / 6 + tileSize.height / 2
        
        verticals = [
            CGPoint(
                x: -(tileSize + horizontalTileSize).width / 2,
                y: vertY
            ),
            CGPoint(
                x: -(tileSize + horizontalTileSize).width / 2,
                y: -vertY
            ),
            CGPoint(
                x: (tileSize + horizontalTileSize).width / 2,
                y: -vertY
            ),
            CGPoint(
                x: (tileSize + horizontalTileSize).width / 2,
                y: vertY
            )
        ]
        
        fillTiles()
        fillConfigs()
        updateArenas()
        buildNodes()
    }
    
    private func initEnemyRoster() {
        enemyRoster = Roster(
            initEnemy(enemy: nil, ofSize: tileSize),
            initEnemy(enemy: nil, ofSize: tileSize),
            initEnemy(enemy: nil, ofSize: tileSize),
            initEnemy(enemy: nil, ofSize: tileSize)
        )
        
        enemyRoster.forEach { [weak self] enemy in
            self?.sceneDelegate?.addChildren(enemy.parts)
        }
    }
    
    private func initEnemy(enemy: Enemy?, ofSize size: CGSize) -> SKIlluminatedSpriteNode {
        return enemy != nil ? SKIlluminatedSpriteNode(imageNamed: enemy!.image) : SKIlluminatedSpriteNode(ofSize: tileSize / 1.5)
    }
}

extension BoardController {
    func update() {
        var node: Node<SKSpriteNode>? = nodes.root
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
        arenas.bookmark.data.updateRoster()
        enemyRoster.forEach { [weak self] node, index in
            guard let self else { return }
            let image = arenas.bookmark.data.roster[index]?.0.image
            let point = arenas.bookmark.data.roster[index]?.1
            node.texture = image != nil ? .init(imageNamed: image!) : nil
            node.aspectFitTo(size: tileSize / 1.5)
            node.position = point ?? .zero
        }
        setEnemiesPerspective()
    }
    
    func wipeEnemies() {
        arenas.bookmark.data.wipeEnemies()
    }
    
    func buildNode(tile: CGPoint, arena: Arena) -> SKSpriteNode {
        let tileNode = SKSpriteNode(imageNamed: "field")
        tileNode.position = tile
        tileNode.aspectFitTo(size: tileSize)
        tileNode.zPosition = AppConstants.Priority.GROUND
        return tileNode
    }
    
    func updateNode(_ node: SKSpriteNode, with arena: Arena) {
        if arena.roster.first != nil || arena.roster.second != nil || arena.roster.third != nil || arena.roster.fourth != nil {
//            node.fillColor = .systemGreen
        } else {
//            node.fillColor = .systemRed
        }
    }
    
    func rebuildCurrentNode() -> SKSpriteNode {
        nodes.updateBookmarked(with: buildNode(tile: tiles.bookmark.data, arena: arenas.bookmark.data))
    }
    
    func redrawCurrentNode() {
        updateNode(nodes.bookmark.data, with: arenas.bookmark.data)
    }
    
    func buildNodes() {
        var newNodes: [SKSpriteNode] = []
        
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

    func getReward() -> Double {
        let networth = currentRunNetworth
        currentRunNetworth = 0
        return networth
    }
    
    func collectTileReward() {
        currentRunNetworth += arenas.bookmark.data.roster.sum { $0?.0.reward ?? 0 }
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
                ArenaConfig(level: 2, enemyLevels: Roster(1, 4, 1, 1)),
                ArenaConfig(level: 3, enemyLevels: Roster(1, 2, 0, nil)),
                ArenaConfig(level: 4, enemyLevels: Roster(0, 0, nil, nil)),
                ArenaConfig(level: 5, enemyLevels: Roster(2, 2, 2, 2)),
                ArenaConfig(level: 6, enemyLevels: Roster(1, 3, 1, 1)),
                ArenaConfig(level: 7, enemyLevels: Roster(0, nil, 4, 1)),
                ArenaConfig(level: 8, enemyLevels: Roster(1, 0, 3, 2)),
                ArenaConfig(level: 9, enemyLevels: Roster(1, 1, 1, 2)),
                ArenaConfig(level: 10, enemyLevels: Roster(1, 3, 2, 0))
            ]
        )
    }
    
    private func setEnemiesPerspective() {
        enemyRoster.forEach { [weak self] enemy, index in
            guard let self else { return }
            enemy.zPosition = AppConstants.Priority.ENEMY.moveFront(
                UInt(self.enemyRoster.countIf { (enemy.frame.minY) < ($0.frame.minY ) })
            )
        }
    }
}
