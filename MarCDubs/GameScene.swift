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
        
        //Creating Mario/Chang
        Mario = SKSpriteNode(imageNamed: "Mario1")
        Mario.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        Mario.size = CGSize(width: 30, height: 45)
        
        Mario.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Mario.size.width, height: Mario.size.height))
        //Assigning 0x1 << 1 to Mario
        Mario.physicsBody?.categoryBitMask = CollisionNames.Mario
        //If Mario hits Ground or Coin
        Mario.physicsBody?.collisionBitMask = CollisionNames.Ground | CollisionNames.Coin
        //Contact Test
        Mario.physicsBody?.contactTestBitMask = CollisionNames.Ground | CollisionNames.Coin
        //Gives Mario gravity
        Mario.physicsBody?.affectedByGravity = true
        self.addChild(Mario)
        
        let groundGroup : TMXObjectGroup = self.Map!.groupNamed("GroundObjects")
        for i in 0..<groundGroup.objects.count {
            
            let groundObject = groundGroup.objects.object(at: i) as! NSDictionary
            
            let width = groundObject.object(forKey: "width") as! String
            let height = groundObject.object(forKey: "height") as! String
            
            let wallSize = CGSize(width: CGFloat(Int(width)!), height: CGFloat(Int(height)!))
            
            let groundSprite = SKSpriteNode(color: UIColor.clear, size: wallSize)
            
            let x = groundObject.object(forKey: "x") as! Int
            let y = groundObject.object(forKey: "y") as! Int
            groundSprite.position = CGPoint(x: x + Int(groundGroup.positionOffset.x) + Int(width)! / 2, y: y + Int(groundGroup.positionOffset.y) + Int(height)! / 2)
            
            groundSprite.physicsBody = SKPhysicsBody(rectangleOf: wallSize)
            groundSprite.physicsBody?.categoryBitMask = CollisionNames.Ground
            groundSprite.physicsBody?.collisionBitMask = CollisionNames.Mario
            groundSprite.physicsBody?.contactTestBitMask = CollisionNames.Mario
            
            groundSprite.physicsBody?.affectedByGravity = false
            groundSprite.physicsBody?.isDynamic = false
            self.addChild(groundSprite)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
