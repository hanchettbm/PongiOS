//
//  GameScene.swift
//  Pong
//
//  Created by Baden Hanchett on 6/24/21.
//

import SpriteKit
import GameplayKit
// Set up game scene class
class GameScene: SKScene {
    
//  Initialize Sprite nodes.
    var ball = SKSpriteNode()
    var player1 = SKSpriteNode()
    var player2 = SKSpriteNode()
//  Set Lables.
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
//  Set up score counter.
    var score = [Int]()
    
//  Look for moves.
    override func didMove(to view: SKView) {
        
//      Run initial game setup.
        startGame()
//      Put labels on the app display.
        topLabel = self.childNode(withName: "topLabel")! as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel")! as! SKLabelNode
//      Set up Sprites that were created in the game scene.
        ball = self.childNode(withName: "ball")! as! SKSpriteNode
        player1 = self.childNode(withName: "player1")! as! SKSpriteNode
        player2 = self.childNode(withName: "player2")! as! SKSpriteNode
        
//      Set paddle positions.
        player2.position.y = (self.frame.height / 2) - 30
        player1.position.y = (-self.frame.height / 2) + 30
//      Start the ball moving in a random direction (That isn't 0).
        var randomInt = Int.random(in: -15..<15)
        while randomInt == 0 {
            randomInt = Int.random(in: -15..<15)
        }
//      Apply the random impulse (force) to the ball.
        ball.physicsBody?.applyImpulse(CGVector(dx: randomInt, dy: -15))
        
//      Make sure the ball stays within the border.
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
//      Remove frition so the ball continually bounces.
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
    }
    
    func startGame() {
        
//      Set up the scoring and then display it on the game view.
        score = [0,0]
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    
    func addScore(playerPoint : SKSpriteNode){
        
//      When score is detected reset ball position.
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
//      If player one scores add a point and send the ball to player 2.
        if playerPoint == player1 {
            score[0] += 1
            var randomInt = Int.random(in: -15..<15)
            while randomInt == 0 {
                randomInt = Int.random(in: -15..<15)
            }
            ball.physicsBody?.applyImpulse(CGVector(dx: randomInt, dy: 15))
        }
//      If player two scores add a point and send the ball to player 1.
        else if playerPoint == player2 {
            score[1] += 1
            var randomInt = Int.random(in: -15..<15)
            while randomInt == 0 {
                randomInt = Int.random(in: -15..<15)
            }
            ball.physicsBody?.applyImpulse(CGVector(dx: randomInt, dy: -15))
        }
//      Update score label.
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    
//  Function that looks for an inital touch.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
//          Split touch input in half so both players can move paddles at the same time on the top and bottom.
            let location = touch.location(in: self)
            
            if location.y > 0 {
//              Move the paddle to the location touched.
                player2.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
            if location.y < 0{
//              Move the paddle to the location touched.
                player1.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
        }
    }
    
//  Looks for continous touches (swipes).
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
//          Split touch input in half so both players can move paddles at the same time on the top and bottom.
            let location = touch.location(in: self)
            
            if location.y > 0 {
//              Move the paddle to the location touched.
                player2.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
            if location.y < 0{
//              Move the paddle to the location touched.
                player1.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
        }
    }
    
//  Update function that renders game frames.
    override func update(_ currentTime: TimeInterval) {
        
//      Checks if ball passed player one paddle and gives calls point function for player 2.
        if ball.position.y <= player1.position.y - 17 {
            addScore(playerPoint: player2)
            
        }
//      Checks if ball passed player two paddle and gives calls point function for player 1.
        else if ball.position.y >= player2.position.y + 17 {
            addScore(playerPoint: player1)
        }
    }
}
