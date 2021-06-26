//
//  GameScene.swift
//  Pong
//
//  Created by Baden Hanchett on 6/24/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var player1 = SKSpriteNode()
    var player2 = SKSpriteNode()
    
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        topLabel = self.childNode(withName: "topLabel")! as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel")! as! SKLabelNode
        
        ball = self.childNode(withName: "ball")! as! SKSpriteNode
        player1 = self.childNode(withName: "player1")! as! SKSpriteNode
        player2 = self.childNode(withName: "player2")! as! SKSpriteNode
        
        player2.position.y = (self.frame.height / 2) - 30
        player1.position.y = (-self.frame.height / 2) + 30
        var randomInt = Int.random(in: -15..<15)
        while randomInt == 0 {
            randomInt = Int.random(in: -15..<15)
        }
        ball.physicsBody?.applyImpulse(CGVector(dx: randomInt, dy: -15))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
    }
    
    func startGame() {
        score = [0,0]
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    
    func addScore(playerPoint : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerPoint == player1 {
            score[0] += 1
            var randomInt = Int.random(in: -15..<15)
            while randomInt == 0 {
                randomInt = Int.random(in: -15..<15)
            }
            ball.physicsBody?.applyImpulse(CGVector(dx: randomInt, dy: 15))
        }
        else if playerPoint == player2 {
            score[1] += 1
            var randomInt = Int.random(in: -15..<15)
            while randomInt == 0 {
                randomInt = Int.random(in: -15..<15)
            }
            ball.physicsBody?.applyImpulse(CGVector(dx: randomInt, dy: -15))
        }
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if location.y > 0 {
                player2.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
            if location.y < 0{
                player1.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if location.y > 0 {
                player2.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
            if location.y < 0{
                player1.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
//        player2.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if ball.position.y <= player1.position.y - 18 {
            addScore(playerPoint: player2)
            
        }
        else if ball.position.y >= player2.position.y + 18 {
            addScore(playerPoint: player1)

            
        }
    }
}
