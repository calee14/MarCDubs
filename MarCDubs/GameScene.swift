//
//  GameScene.swift
//  MarCDubs
//
//  Created by Cappillen on 3/7/17.
//  Copyright © 2017 Cappillen. All rights reserved.
//

import SpriteKit
import GameplayKit

struct CollisionNames {
    static let Mario : UInt32 = 0x1 << 1
    static let Ground : UInt32 = 0x1 << 2
    static let Coin : UInt32 = 0x1 << 4
}
class GameScene: SKScene {
    
    let Map = JSTileMap(named: "level1.tmx")
    var Mario = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        Map?.position = CGPoint(x: 0, y: 0)
        self.addChild(Map!)
        
        Mario = SKSpriteNode(imageNamed: "Mario1")
        Mario.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        Mario.size = CGSize(width: 30, height: 45)
        
        Mario.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Mario.size.width, height: Mario.size.height))
        //Assigning 0x1 << 1 to Mario
        Mario.physicsBody?.categoryBitMask = CollisionNames.Mario
        //If Mario hits Ground or Coin
        Mario.physicsBody?.collisionBitMask = CollisionNames.Ground | CollisionNames.Coin
        //Gives Mario gravity
        Mario.physicsBody?.affectedByGravity = true
        self.addChild(Mario)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
