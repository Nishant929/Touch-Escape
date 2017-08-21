//
//  GameElements.swift
//  Touch Escape
//
//  Created by Nishant Hooda on 11/07/17.
//  Copyright © 2017 digix. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let player:UInt32 = 0x00
    static let obstacle:UInt32 = 0x01
}

enum ObstacleType:Int {
    case Small = 0
    case Medium = 1
    case Large = 2
}

enum RowType:Int {
    case OneSmall = 0
    case OneMedium = 1
    case OneLarge = 2
    case TwoSmall = 3
    case TwoMedium = 4
    case ThreeSmall = 5
}

var score = 0
var arrayOfObstacles = [ObstacleType]()

extension GameScene {
    
    func addPlayer()    {
        player = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: self.size.width/2, y: 350)
        player.name = "PLAYER"
        player.physicsBody?.isDynamic = false
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = CollisionBitMask.player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = CollisionBitMask.obstacle
        
        player2 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 50, height: 50))
        player2.position = CGPoint(x: self.size.width/2, y: 350)
        player2.name = "PLAYER"
        player2.physicsBody?.isDynamic = false
        player2.physicsBody = SKPhysicsBody(rectangleOf: player2.size)
        player2.physicsBody?.categoryBitMask = CollisionBitMask.player
        player2.physicsBody?.collisionBitMask = 0
        player2.physicsBody?.contactTestBitMask = CollisionBitMask.obstacle

        addChild(player)
        addChild(player2)
        
        initialPlayerPosition = player.position
    }
    
    func addObstacle(type: ObstacleType) -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: UIColor.white, size: CGSize(width: 0, height: 30))
        obstacle.name = "OBSTACLE"
        obstacle.physicsBody?.isDynamic = true
        switch type {
        case .Small:
            obstacle.size.width = self.size.width * 0.2
            break
        case .Medium:
            obstacle.size.width = self.size.width * 0.35
            break
        case .Large:
            obstacle.size.width = self.size.width * 0.75
            break
        }
        obstacle.position = CGPoint(x: 0, y: self.size.width + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.contactTestBitMask = CollisionBitMask.obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        return obstacle
        
    }
    
    func addMovement(obstacle:SKSpriteNode) {
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x:obstacle.position.x, y: -obstacle.size.height), duration: TimeInterval(3)))
        actionArray.append(SKAction.removeFromParent())
        obstacle.run(SKAction.sequence(actionArray))
    }
    
    func addRow(type: RowType) {
        switch type {
        case .OneSmall:
            let obstacle = addObstacle(type: .Small)
            obstacle.position = CGPoint(x: self.size.width / 2, y: self.size.height - 10)
            addMovement(obstacle: obstacle)
            addChild(obstacle)
            break
            
        case .OneMedium:
            let obstacle = addObstacle(type: .Medium)
            obstacle.position = CGPoint(x: self.size.width / 2, y: self.size.height - 10)
            addMovement(obstacle: obstacle)
            addChild(obstacle)
            break
            
        case .OneLarge:
            let obstacle = addObstacle(type: .Large)
            obstacle.position = CGPoint(x: self.size.width / 2, y: self.size.height - 10)
            addMovement(obstacle: obstacle)
            addChild(obstacle)
            break
            
        case .TwoSmall:
            let obstacle1 = addObstacle(type: .Small)
            let obstacle2 = addObstacle(type: .Small)
            obstacle1.position = CGPoint(x: obstacle1.size.width / 2 + 50, y: self.size.height - 10)
            obstacle2.position = CGPoint(x: self.size.width - obstacle2.size.width / 2 - 50 , y: self.size.height - 10)
            addMovement(obstacle: obstacle1)
            addMovement(obstacle: obstacle2)
            addChild(obstacle1)
            addChild(obstacle2)
            break
            
        case .TwoMedium:
            let obstacle1 = addObstacle(type: .Medium)
            let obstacle2 = addObstacle(type: .Medium)
            obstacle1.position = CGPoint(x: obstacle1.size.width / 2 + 50, y: self.size.height - 10) //Left
            obstacle2.position = CGPoint(x: self.size.width - obstacle2.size.width / 2 - 50, y: self.size.height - 10) //Right
            addMovement(obstacle: obstacle1)
            addMovement(obstacle: obstacle2)
            addChild(obstacle1)
            addChild(obstacle2)
            break
            
        case .ThreeSmall:
            let obstacle1 = addObstacle(type: .Small)
            let obstacle2 = addObstacle(type: .Small)
            let obstacle3 = addObstacle(type: .Small)
            obstacle1.position = CGPoint(x: obstacle1.size.width / 2 + 50, y: self.size.height - 10) //Left
            obstacle2.position = CGPoint(x: self.size.width - obstacle2.size.width / 2 - 50, y: self.size.height - 10) //Right
            obstacle3.position = CGPoint(x: self.size.width / 2, y: self.size.height - 10) //Centre
            addMovement(obstacle: obstacle1)
            addMovement(obstacle: obstacle2)
            addMovement(obstacle: obstacle3)
            addChild(obstacle1)
            addChild(obstacle2)
            addChild(obstacle3)
            break
        }
    }
}
