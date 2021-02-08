//
//  PlayerNode.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class PlayerNode : SKSpriteNode {
    
    //player attributes
    var left = false
    var right = false
    
    var jump = false
    var landed = false
    var grounded = false
    
    var attack = false
    
    var dead = false
    
    var maxJump : CGFloat = 15.0
    
    var health : CGFloat = 6.0
    var candyAmount : CGFloat = 5.0
    
    //movement
    var airAccel : CGFloat = 0.1
    var airDecel : CGFloat = 0.0
    var groundAccel : CGFloat = 0.2
    var groundDecel : CGFloat = 0.5
    
    //direction animation is facing
    var facing : CGFloat = 1.0
    
    //speed
    var hSpeed:CGFloat = 0.0
    
    var runSpeed:CGFloat = 4.0
    
    //hurt boxes and hit boxes
    var hurtBox : Hurtbox?
    var hitBox : Hitbox?
    
    var hit = false
    var hitStun : CGFloat = 0
    var hitBY : Hitbox?
    
    //player state
    var state:GKStateMachine?
    
    /**
     set up hurtboxes
     */
    func setHurtbox(size: CGSize) {
        //size and position
        hurtBox = Hurtbox(color: .green, size: size)
        hurtBox?.position = CGPoint(x: (hurtBox?.xOffset)!, y: (hurtBox?.yOffset)!)
        hurtBox?.alpha = (hurtBox?.image_alpha)!
        hurtBox?.zPosition = 50
        
        //adds to player
        self.addChild(hurtBox!)
    }
    
    /**
     set up hit boxes
     */
    func setHitbox(size: CGSize) {
        //size and position
        hitBox = Hitbox(color: .red, size: size)
        hitBox?.position = CGPoint(x: (hitBox?.xOffset)!, y: (hitBox?.yOffset)!)
        hitBox?.alpha = (hitBox?.image_alpha)!
        hitBox?.zPosition = 50
        
        //adds to player
        self.addChild(hitBox!)
    }
    
    /**
     sets up the state machine
     */
    func setUpStatemachine() {
        //states player can be in
        let idleState = IdleState(with: self)
        let attackState = AttackState(with: self)
        let damageState = DamageState(with: self)
        
        //adds states to state machine
        state = GKStateMachine(states: [idleState, attackState, damageState])
        
        //adds states to player
        state?.enter(IdleState.self)
    }
    
    /**
     gives the player physics
     */
    func createPhysics() {
        //gives player a physics body
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 25, height: 25), center: CGPoint(x: 0, y: -7))
        
        //sets physics settings
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.0
        physicsBody?.friction = 0.0
        
        //sets collision and contact settings
        physicsBody?.categoryBitMask = 1
        physicsBody?.collisionBitMask = 6
        physicsBody?.contactTestBitMask = 4
    }
}
