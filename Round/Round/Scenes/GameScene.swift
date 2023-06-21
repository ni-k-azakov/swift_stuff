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
    private var board: BoardController!
    private var player: PlayerController = PlayerController()
    
    var networthLabel: SKLabelNode!
    var shownNetworth: Double = 0 {
        didSet(newValue) {
            networthLabel.text = String(UInt64(newValue))
        }
    }
    
    override func didMove(to view: SKView) {
        initBoard()
        initAvatar()
        initPersona()
        initUI()
    }
    
    override func update(_ currentTime: TimeInterval) {
        shownNetworth = shownNetworth + min(player.networth - shownNetworth, 9)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hit()
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
        
        var node: Node<SKShapeNode>? = board.nodes.root
        while let unwrapped = node {
            replaceTile(nil, with: unwrapped.data)
            node = unwrapped.next
        }
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
            origin: avatarPos(root: board.tiles.bookmark.data),
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
    
    private func initUI() {
        let screenHeight = self.frame.height
        
        networthLabel = SKLabelNode(text: "0")
        networthLabel.position = CGPoint(x: 0, y: screenHeight / 3)
        
        self.addChild(networthLabel)
    }
}

// MARK: - Drawing
extension GameScene {
    private func replaceTile(_ tile: SKShapeNode?, with newTile: SKShapeNode) {
        tile?.removeFromParent()
        self.addChild(newTile)
    }
    
    private func resetArenas() {
        board.updateArenas()
        board.update()
    }
}

// MARK: -
extension GameScene {
    private func avatarPos(root: CGPoint) -> CGPoint {
        root + CGPoint(x: self.board.tileSize.width / 2, y: self.board.tileSize.height / 3)
    }
    
    private func moveToNextTile() {
        player.avatar.run(.move(to: avatarPos(root: board.tiles.bookmark.data), duration: 0))
        player.avatar.run(.move(to: avatarPos(root: board.move().tiles.bookmark.data), duration: 0.15))
        
        if board.tiles.bookmark === board.tiles.root { resetArenas() }
        spawnEnemies()
    }
    
    private func spawnEnemies() {
        board.updateRoster().forEach { [weak self] enemy in
            if let enemy, let self { self.addChild(enemy) }
        }
    }
    
    private func hit() {
        player.dealDamage()
        player.collectMoney(1)
        
        if player.dealtDamage >= board.arenas.bookmark.data.roster.map(action: { $0?.0 ?? Enemy.dummy() }).max(\.maxHP) {
            player.collectMoney(board.getReward())
            board.wipeEnemies()
            board.redrawCurrentNode()
            moveToNextTile()
            player.resetDamage()
        }
    }
}


