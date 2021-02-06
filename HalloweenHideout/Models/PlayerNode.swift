//
//  PlayerNode.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 2/3/21.
//

import SpriteKit
import GameplayKit

class PlayerNode : SKSpriteNode {
    
    var left = false
    var right = false
    
    var jump = false
    var landed = false
    var grounded = false
    
    var attack = false
    
    var maxJump : CGFloat = 15.0
    
    var health : CGFloat = 6.0
    var candyAmount : CGFloat = 0.0
    
    var airAccel : CGFloat = 0.1
    var airDecel : CGFloat = 0.0
    var groundAccel : CGFloat = 0.2
    var groundDecel : CGFloat = 0.5
    
    var facing : CGFloat = 0.0
    
    var hSpeed:CGFloat = 0.0
    
    var runSpeed:CGFloat = 4.0
    
    var hurtBox : Hurtbox?
    var hitBox : Hitbox?
    
    var hit = false
    var hitStun : CGFloat = 0
    var hitBY : Hitbox?
    
    var state:GKStateMachine?
    
    func setHurtbox(size: CGSize) {
        hurtBox = Hurtbox(color: .green, size: size)
        hurtBox?.position = CGPoint(x: (hurtBox?.xOffset)!, y: (hurtBox?.yOffset)!)
        hurtBox?.alpha = (hurtBox?.image_alpha)!
        hurtBox?.zPosition = 50
        self.addChild(hurtBox!)
    }
    
    func setHitbox(size: CGSize) {
        hitBox = Hitbox(color: .red, size: size)
        hitBox?.position = CGPoint(x: (hitBox?.xOffset)!, y: (hitBox?.yOffset)!)
        hitBox?.alpha = (hitBox?.image_alpha)!
        hitBox?.zPosition = 50
        self.addChild(hitBox!)
    }
    
    func setUpStatemachine() {
        let idleState = IdleState(with: self)
        let attackState = AttackState(with: self)
        let damageState = DamageState(with: self)
        state = GKStateMachine(states: [idleState, attackState, damageState])
        state?.enter(IdleState.self)
    }
    
    func createPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 25, height: 25), center: CGPoint(x: 0, y: -7))
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.0
        physicsBody?.friction = 0.0
        physicsBody?.categoryBitMask = ColliderType.PLAYER
        physicsBody?.collisionBitMask = ColliderType.GROUND
    }
}
