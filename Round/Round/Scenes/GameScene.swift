//
//  GameScene.swift
//  Round
//
//  Created by Nikita Kazakov on 15.06.2023.
//

import SwiftUI
import SpriteKit
import GameplayKit

final class GameScene: SKScene, SKPhysicsContactDelegate {
    // Paw army
    var shownNetworth: Double = 0
    var shownCurrentRun: Double = 0
    
    private var board: BoardController!
    private var player: PlayerController = PlayerController()
    private var updateBindings: () -> Void = {}
    
    override func didMove(to view: SKView) {
        initBoard()
        initAvatar()
        initPersona()
    }
    
    override func update(_ currentTime: TimeInterval) {
        shownNetworth = shownNetworth + min(player.networth - shownNetworth, getChangeSpeed(player.networth, shownNetworth))
        shownCurrentRun = shownCurrentRun + min(board.currentRunNetworth - shownCurrentRun, getChangeSpeed(board.currentRunNetworth, shownCurrentRun))
        updateBindings()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hit()
    }
    
    func bind(onMoneyChange: @escaping (Double) -> Void, onCurrentRunChange: @escaping (Double) -> Void) {
        updateBindings = { [weak self] in
            guard let self else { return }
            onMoneyChange(shownNetworth)
            onCurrentRunChange(shownCurrentRun)
        }
    }
    
    private func getChangeSpeed(_ maxValue: Double, _ currentValue: Double) -> Double {
        max((maxValue - currentValue) / 100, 1) * 5 + 4
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
        initEnemies()
        
        var node: Node<SKSpriteNode>? = board.nodes.root
        while let unwrapped = node {
            replaceTile(nil, with: unwrapped.data)
            node = unwrapped.next
        }
    }
    
    private func initSpawnBoxes() {
        let spawnBox = board.innerField / CGSize(width: 2, height: 5) + CGPoint(x: board.innerField.width / 4, y: board.innerField.height / 3 * 2)
        
        board.setSpawnBoxes(in: spawnBox)
        
//        let spawnBoxShape = SKShapeNode(rect: spawnBox)
//        spawnBoxShape.fillColor = .systemBlue
//        spawnBoxShape.zPosition = AppConstants.Priority.BACKGROUND.moveFront(1)
//        self.addChild(spawnBoxShape)
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
    
    private func initEnemies() {
        board.enemyRoster.forEach { [weak self] enemy in
            if let self { self.addChild(enemy) }
        }
    }
}

// MARK: - Drawing
extension GameScene {
    private func replaceTile(_ tile: SKSpriteNode?, with newTile: SKSpriteNode) {
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
        root - CGPoint(x: 0, y: self.board.tileSize.height / 6)
    }
    
    private func moveToNextTile() {
        player.avatar.run(.move(to: avatarPos(root: board.tiles.bookmark.data), duration: 0))
        player.avatar.run(.move(to: avatarPos(root: board.move().tiles.bookmark.data), duration: 0.15))
        
        if board.tiles.bookmark === board.tiles.root {
            player.collectMoney(board.getReward())
            resetArenas()
        }
        respawnEnemies()
    }
    
    private func respawnEnemies() {
        board.updateRoster()
    }
    
    private func hit() {
        player.dealDamage()
        player.collectMoney(1)
        
        if player.dealtDamage >= board.arenas.bookmark.data.roster.map(action: { $0?.0 ?? Enemy.dummy() }).max(\.maxHP) {
            board.collectTileReward()
            board.wipeEnemies()
            board.redrawCurrentNode()
            moveToNextTile()
            player.resetDamage()
        }
    }
}


