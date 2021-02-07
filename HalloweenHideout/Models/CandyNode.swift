//
//  Candy.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 1/19/21.
//

import SpriteKit
import GameplayKit

class CandyNode : SKSpriteNode {
    
    var value : CGFloat = 0.0
    var collected = false
    var candyAmount : CGFloat = 0.0
    var candyValue : CGFloat = 0.0
    
    var hitBox : Hitbox?
    var hurtBox : Hurtbox?
    var hitBY : Hitbox?
    
    func setHitbox(size: CGSize) {
        hitBox = Hitbox(color: .red, size: size)
        hitBox?.position = CGPoint(x: (hitBox?.xOffset)!, y: (hitBox?.yOffset)!)
        hitBox?.alpha = (hitBox?.image_alpha)!
        hitBox?.zPosition = 50
        self.addChild(hitBox!)
    }
    
    func setHurtbox(size: CGSize) {
        hurtBox = Hurtbox(color: .green, size: size)
        hurtBox?.position = CGPoint(x: (hurtBox?.xOffset)!, y: (hurtBox?.yOffset)!)
        hurtBox?.alpha = (hurtBox?.image_alpha)!
        hurtBox?.zPosition = 50
        self.addChild(hurtBox!)
    }
    
    func createPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 25, height: 25), center: CGPoint(x: 0, y: -7))
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.0
        physicsBody?.friction = 0.0
        physicsBody?.categoryBitMask = 4
        physicsBody?.collisionBitMask = 3
        physicsBody?.contactTestBitMask = 2
    }
}

