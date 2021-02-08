//
//  IdleState.swift
//  HalloweenHideout
//
//

import GameplayKit

class IdleState : GKState {
    
    var pNode:PlayerNode
    
    /**
     initalizes player node
     */
    init(with node: PlayerNode) {
        self.pNode = node
    }
    
    /**
     update the frames
     */
    override func update(deltaTime seconds: TimeInterval) {
        var aSpeed: CGFloat = 0.0
        var dSpeed: CGFloat = 0.0
        
        //sets the ground and air movement
        if(pNode.grounded) {
            aSpeed = pNode.groundAccel
            dSpeed = pNode.groundDecel
        } else {
            aSpeed = pNode.airAccel
            dSpeed = pNode.airDecel
        }
        
        //movement
        if pNode.left {
            pNode.facing = -1.0
            pNode.xScale = -1.0
            pNode.hSpeed = approach(start: pNode.hSpeed, end: -pNode.runSpeed, shift: aSpeed)
        } else if pNode.right {
            pNode.facing = 1.0
            pNode.xScale = 1.0
            pNode.hSpeed = approach(start: pNode.hSpeed, end: pNode.runSpeed, shift: aSpeed)
        } else {
            pNode.hSpeed = approach(start: pNode.hSpeed, end: 0.0, shift: dSpeed)
        }
        
        //jump
        if (pNode.grounded) {
            if !pNode.landed {
                //squashAndStretch(xScale: 1.3, yScale: 0.7)
                pNode.physicsBody?.velocity = CGVector(dx: (pNode.physicsBody?.velocity.dx)!, dy: 0.0)
                pNode.landed = true
            }
            if pNode.jump {
                pNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: pNode.maxJump))
                pNode.grounded = false
                pNode.physicsBody?.categoryBitMask = 0
                pNode.physicsBody?.collisionBitMask = 0
                squashAndStretch(xScale: 0.7, yScale: 1.3)
            }
        }
        
        //jump
        if(!pNode.grounded) {
            if (pNode.physicsBody?.velocity.dy)! < CGFloat(0.0) {
                pNode.physicsBody?.categoryBitMask = ColliderType.PLAYER
                pNode.physicsBody?.collisionBitMask = ColliderType.GROUND
                pNode.jump = false
            }
            if ((pNode.physicsBody?.velocity.dy)! > CGFloat(0.0) && !pNode.jump) {
                pNode.physicsBody?.velocity.dy *= 0.5
            }
            pNode.landed = false
        }
        
        //attack
        if(pNode.attack) {
            self.stateMachine?.enter(AttackState.self)
        }
        
        //collision detection - enemy
        if(pNode.hit){
            squashAndStretch(xScale: 1.3, yScale: 1.3)
            pNode.hSpeed = (pNode.hitBY?.xHit)!
            pNode.hitStun = (pNode.hitBY?.hitStun)!
            pNode.facing = ((pNode.hitBY?.parent as! PlayerNode).facing) * -1
            pNode.xScale = (pNode.facing)
            pNode.hit = false
            pNode.state?.enter(DamageState.self)
        }
        
        pNode.xScale = approach(start: pNode.xScale, end: pNode.facing, shift: 0.05)
        pNode.yScale = approach(start: pNode.yScale, end: 1, shift: 0.05)
        
        pNode.position.x = pNode.position.x + pNode.hSpeed
    }
    
    /**
     node speed
     */
    func approach(start: CGFloat, end: CGFloat, shift: CGFloat) -> CGFloat{
        if(start < end) {
            return min(start + shift, end)
        } else {
            return max(start - shift, end)
        }
    }
    
    /**
     size scale
     */
    func squashAndStretch(xScale: CGFloat, yScale: CGFloat) {
        pNode.xScale = xScale * pNode.facing
        pNode.yScale = yScale
    }
    
}
