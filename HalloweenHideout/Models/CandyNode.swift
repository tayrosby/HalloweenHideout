//
//  Candy.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class CandyNode : SKSpriteNode {
    
    var collected = false
    var candyAmount : CGFloat = 0.0
    var candyValue : CGFloat = 0.0
    
    /**
     gives the candy physics
     */
    func createPhysics() {
        //gives the candy a physics body
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 25, height: 25), center: CGPoint(x: 0, y: -7))
        
        //sets up physics settings
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.0
        physicsBody?.friction = 0.0
        
        //sets up collision and contact settings
        physicsBody?.categoryBitMask = 4
        physicsBody?.collisionBitMask = 3
        physicsBody?.contactTestBitMask = 2
    }
}

