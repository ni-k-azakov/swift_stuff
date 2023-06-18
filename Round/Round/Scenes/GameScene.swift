//
//  GameScene.swift
//  Round
//
//  Created by Nikita Kazakov on 15.06.2023.
//

import SpriteKit
import GameplayKit

final class GameScene: SKScene, SKPhysicsContactDelegate {
    // Paw army
//    private let slashCategory: UInt32 = 0x1 << 0
    private var board: BoardController!
    private var player: PlayerController = PlayerController()
    
//    private var swordHit: SKEmitterNode!
    
    override func didMove(to view: SKView) {
//        initWorld()
        initBoard()
        initAvatar()
        initPersona()
        drawBoard()
//        initOther()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hit()
        moveToNextTile()
        spawnEnemies()
    }
}

// MARK: - Inits
extension GameScene {
    private func initBoard() {
        let screenWidth = self.frame.width
        let screenHeight = self.frame.height
        
        board = BoardController(screenWidth: screenWidth, screenHeight: screenHeight)
        self.addChild(board.battleField)
        initSpawnBoxes()
    }
    
    private func initSpawnBoxes() {
        let spawnBox = board.innerField / CGSize(width: 2, height: 5) + CGPoint(x: board.innerField.width / 4, y: board.innerField.height / 3 * 2)
        
        board.setSpawnBoxes(in: spawnBox)
        
        let spawnBoxShape = SKShapeNode(rect: spawnBox)
        spawnBoxShape.fillColor = .systemBlue
        spawnBoxShape.zPosition = AppConstants.Priority.BACKGROUND.moveFront(1)
        self.addChild(spawnBoxShape)
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
    
//    private func initWorld() {
//        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
//        self.physicsWorld.contactDelegate = self
//    }
}

// MARK: -
extension GameScene {
    private func moveToNextTile() {
        var tile = board.tiles.bookmark.data
        player.avatar.run(.move(
            to: CGPoint(x: tile.x + board.tileSize.width / 2, y: tile.y + board.tileSize.height / 4),
            duration: 0)
        )
        
        tile = board.tiles.moveBookmark()
        board.arenas.moveBookmark()
        board.nodes.moveBookmark()
        
        player.avatar.run(.move(
            to: CGPoint(x: tile.x + board.tileSize.width / 2, y: tile.y + board.tileSize.height / 4),
            duration: 0.15)
        )
    }
    
    private func spawnEnemies() {
        board.updateRoaster()
        board.enemyRoaster.forEach { [weak self] enemy in
            if let enemy, let self { self.addChild(enemy) }
        }
    }
    
    private func hit() {
        board.dealDamage(5) // TODO: damage
        redrawTile(board.nodes.bookmark.data, with: board.rebuildCurrentNode())
    }
    
    private func drawBoard() {
        var node: Node<SKShapeNode>? = board.nodes.root
        while let unwrapped = node {
            redrawTile(nil, with: unwrapped.data)
            node = unwrapped.next
        }
    }
    
    private func redrawTile(_ tile: SKShapeNode?, with newTile: SKShapeNode) {
        tile?.removeFromParent()
        self.addChild(newTile)
    }
}


