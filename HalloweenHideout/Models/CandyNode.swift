//
//  Candy.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 1/19/21.
//

import SpriteKit
import GameplayKit

class CandyNode : SKSpriteNode {
    
    func createPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 25, height: 25), center: CGPoint(x: 0, y: -7))
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.0
        physicsBody?.friction = 0.0
        //physicsBody?.categoryBitMask = ColliderType.CANDY
        physicsBody?.collisionBitMask = ColliderType.GROUND
    }
}

