//
//  GameScene.swift
//  Round
//
//  Created by Nikita Kazakov on 15.06.2023.
//

import SpriteKit
import GameplayKit

fileprivate typealias EnemyDispenser = EntityManager<String>
fileprivate typealias EnemyDispensersRoaster = (EnemyDispenser, EnemyDispenser, EnemyDispenser, EnemyDispenser)
fileprivate typealias BattleFieldRoaster = (SKSpriteNode?, SKSpriteNode?, SKSpriteNode?, SKSpriteNode?)

final class GameScene: SKScene, SKPhysicsContactDelegate {
    // Paw army
//    private let slashCategory: UInt32 = 0x1 << 0
    private let enemyDispencers: EnemyDispensersRoaster = (
        EnemyDispenser(entities: ["goblin1"]),
        EnemyDispenser(entities: ["goblin1"]),
        EnemyDispenser(entities: ["goblin1"]),
        EnemyDispenser(entities: ["goblin1"])
    )
    
    private var board: BoardController = BoardController()
    private var battleFieldRoaster: BattleFieldRoaster = (nil, nil, nil, nil)
    private var player: PlayerController = PlayerController()
    
//    private var swordHit: SKEmitterNode!
    
    override func didMove(to view: SKView) {
        initWorld()
        initBoard()
        initBattleField()
        initAvatar()
        initPersona()
        initSpawnBoxes()
//        initOther()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveToNextTile()
        spawnEnemies()
    }
}

extension GameScene {
    @discardableResult private func spawnEnemy(ofSize size: CGSize, from dispencer: EnemyDispenser, at point: CGPoint? = nil) -> SKSpriteNode {
        let enemy = dispencer.nextEnemy()
        let enemySprite = SKSpriteNode(imageNamed: enemy)
        let position = point != nil ? point! : dispencer.nextPosition()
        enemySprite.position = position
        enemySprite.zPosition = AppConstants.Priority.ENEMY
        enemySprite.aspectFitTo(size: size)
        self.addChild(enemySprite)
        return enemySprite
    }
    
    private func moveToNextTile() {
        var tile = board.tiles.bookmark.data
        player.avatar.run(.move(
            to: CGPoint(x: tile.x + board.tileSize.width / 2, y: tile.y + board.tileSize.height / 4),
            duration: 0)
        )
        
        tile = board.tiles.moveBookmark()
        player.avatar.run(.move(
            to: CGPoint(x: tile.x + board.tileSize.width / 2, y: tile.y + board.tileSize.height / 4),
            duration: 0.15)
        )
    }
    
    func spawnEnemies() {
        battleFieldRoaster.0?.removeFromParent()
        battleFieldRoaster.1?.removeFromParent()
        battleFieldRoaster.2?.removeFromParent()
        battleFieldRoaster.3?.removeFromParent()
        
        battleFieldRoaster = (
            spawnEnemy(ofSize: board.tileSize / 1.5, from: enemyDispencers.0),
            spawnEnemy(ofSize: board.tileSize / 1.5, from: enemyDispencers.1),
            spawnEnemy(ofSize: board.tileSize / 1.5, from: enemyDispencers.2),
            spawnEnemy(ofSize: board.tileSize / 1.5, from: enemyDispencers.3)
        )
        
        positionEnemies()
    }
    
    func positionEnemies() {
        let roasterSequence = [battleFieldRoaster.0, battleFieldRoaster.1, battleFieldRoaster.2, battleFieldRoaster.3]
        
        var zPosList: [UInt] = [1, 1, 1, 1]
        for i in 0..<4 {
            zPosList[i] = UInt(roasterSequence.filter { ($0?.frame.minY ?? 0) > (roasterSequence[i]?.frame.minY ?? 0) }.count)
        }
        
        battleFieldRoaster.0?.zPosition = AppConstants.Priority.ENEMY.moveFront(zPosList[0])
        battleFieldRoaster.1?.zPosition = AppConstants.Priority.ENEMY.moveFront(zPosList[1])
        battleFieldRoaster.2?.zPosition = AppConstants.Priority.ENEMY.moveFront(zPosList[2])
        battleFieldRoaster.3?.zPosition = AppConstants.Priority.ENEMY.moveFront(zPosList[3])
    }
    
    func hit() {
        
    }
    
    private func drawTile(tile: CGPoint, arena: Arena) {
        let tileNode = SKShapeNode(rect: CGRect(origin: tile, size: board.tileSize))
        tileNode.fillColor = .systemGreen
        tileNode.zPosition = AppConstants.Priority.GROUND
        self.addChild(tileNode)
        
        let label = SKLabelNode(text: "\(arena.background)")
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.position = tileNode.frame.center
        tileNode.addChild(label)
    }
}


// MARK: - Inits
extension GameScene {
    private func initSpawnBoxes() {
        let spawnBox = board.innerField / CGSize(width: 2, height: 5) + CGPoint(x: board.innerField.width / 4, y: board.innerField.height / 3 * 2)
        // Top
        enemyDispencers.0.set(newSpawnBox: spawnBox * CGSize(width: 0.5, height: 2 / 3) + CGPoint(x: spawnBox.width / 4, y: 0))
        // Bottom
        enemyDispencers.1.set(newSpawnBox: spawnBox * CGSize(width: 0.5, height: 1 / 3) + CGPoint(x: spawnBox.width / 4, y: spawnBox.height * 2 / 3))
        // Left
        enemyDispencers.2.set(newSpawnBox: spawnBox / CGSize(width: 4, height: 1))
        // Right
        enemyDispencers.3.set(newSpawnBox: spawnBox / CGSize(width: 4, height: 1) + CGPoint(x: spawnBox.width * 3 / 4, y: 0))
        
        let spawnBoxShape = SKShapeNode(rect: spawnBox)
        spawnBoxShape.fillColor = .systemBlue
        spawnBoxShape.zPosition = AppConstants.Priority.BACKGROUND.moveFront(1)
        self.addChild(spawnBoxShape)
    }
    
    private func initBattleField() {
        board.initBattleField()
        self.addChild(board.battleField)
    }
    
    private func initAvatar() {
        player.initAvatar(in: CGRect(
            origin: CGPoint(x: board.tiles.bookmark.data.x + board.tileSize.width / 2, y: board.tiles.bookmark.data.y + board.tileSize.height / 4),
            size: board.tileSize / 2
        ))
        self.addChild(player.avatar)
    }
    
    private func initPersona() {
        player.initPersona(in: CGRect(
            origin: CGPoint(x: 0, y: board.innerField.minY + board.innerField.height / 4),
            size: board.tileSize
        ))
        self.addChild(player.persona)
    }
    
//    private func initOther() {
//        swordHit = SKEmitterNode(fileNamed: "SwordHitParticle")
//        swordHit.position = CGPoint(x: 0, y: -140)
//        swordHit.advanceSimulationTime(2)
//        swordHit.zPosition = AppConstants.Priority.PLAYER.particle
//        self.addChild(swordHit)
//    }
    
    private func initWorld() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    private func initBoard() {
        let screenWidth = self.frame.width
        let screenHeight = self.frame.height
        
        board.initBoard(screenWidth: screenWidth, screenHeight: screenHeight)
        board.fillTiles()
        board.fillArenas()
        
        var unsafeArena: Node? = board.arenas.root
        var unsafeTile: Node? = board.tiles.root
        
        while let safeArena = unsafeArena, let safeTile = unsafeTile {
            let arenaData = safeArena.data
            let tileData = safeTile.data
            drawTile(tile: tileData, arena: arenaData)
            unsafeArena = safeArena.next
            unsafeTile = safeTile.next
        }
    }
}
