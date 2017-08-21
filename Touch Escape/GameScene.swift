//
//  GameScene.swift
//  Touch Escape
//
//  Created by Nishant Hooda on 11/07/17.
//  Copyright © 2017 digix. All rights reserved.
//

import SpriteKit
import UIKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {

    var player: SKSpriteNode!
    var player2: SKSpriteNode!
    var backgroundMusic: AVAudioPlayer?
    var gameOver = false
    var displayScore: SKLabelNode!
    
    var initialPlayerPosition: CGPoint!
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        displayScore = SKLabelNode(fontNamed: "Arial")
        displayScore.fontSize = 50
        displayScore.position = CGPoint(x: self.size.width - 100, y: self.size.height - 40)
        displayScore.text = "Score : "
        //addChild(displayScore)
        gameOver = false
        
            let bgMusicURL = Bundle.main.url(forResource: "bgMusic", withExtension: "mp3")
            do {
                try backgroundMusic = AVAudioPlayer(contentsOf: bgMusicURL!)
                backgroundMusic?.prepareToPlay()
                backgroundMusic?.play()
            } catch {
                print("Can't Play Music")
        }
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        addPlayer()
    }
    
    
    func addRandomRow() {
        let randomNumber = Int(arc4random_uniform(6))
        switch randomNumber {
        case 0:
            addRow(type: RowType(rawValue: 0)!)
            break
        case 1:
            addRow(type: RowType(rawValue: 1)!)
            break
        case 2:
            addRow(type: RowType(rawValue: 2)!)
            break
        case 3:
            addRow(type: RowType(rawValue: 3)!)
            break
        case 4:
            addRow(type: RowType(rawValue: 4)!)
            break
        case 5:
            addRow(type: RowType(rawValue: 5)!)
            break
        default:
            break
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let maximumPossibleForce = touch.maximumPossibleForce
            let force = touch.force
            let normalizedForce = force / maximumPossibleForce
            player.position.x = (self.size.width / 2) - normalizedForce * (self.size.width / 2 - 25)
            player2.position.x = (self.size.width / 2) + normalizedForce * (self.size.width / 2 - 25)
            if gameOver == false {
                score += 1
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameOver == false {
        score += 1
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetPlayerPosition()
    }
    
    func resetPlayerPosition () {
        player2.position = initialPlayerPosition
        player.position = initialPlayerPosition
    }
    
    var lastUpdateTimeInterval = TimeInterval()
    var lastYieldTimeInterval = TimeInterval()
    
    func updateWithTimeSinceLastUpdate(timeSinceLastUpdate:CFTimeInterval)  {
        lastYieldTimeInterval += timeSinceLastUpdate
        if lastYieldTimeInterval > 0.8 {
            lastYieldTimeInterval = 0.0
            addRandomRow()
           // updateScore()
        }
        
    }
    
    /*func updateScore() {
        let wait = SKAction.wait(forDuration: 1)
        let action = SKAction.run({self.displayScore.text?.removeAll();
            self.displayScore.text = "Score : \(score)"})
        run(SKAction.repeatForever(SKAction.sequence([wait,action])))
    }*/
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        var timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        if timeSinceLastUpdate > 1 {
            timeSinceLastUpdate = 1/60
            lastUpdateTimeInterval = currentTime
        }
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate: timeSinceLastUpdate)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "PLAYER" {
            gameOver = true
            showGameOver()
            score = 0
        }
    }
    
    func showGameOver() {
        let transistion = SKTransition.fade(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: self.size)
        self.view?.presentScene(gameOverScene, transition: transistion)
    }
    
}
