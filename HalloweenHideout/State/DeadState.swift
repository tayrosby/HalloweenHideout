//
//  DeadState.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class DeadState : GKState {
    
    var pNode:PlayerNode?
    
    var activeTime = 0.4
    private var lastUpdateTime : TimeInterval = 0
    
    //initalizes player
    init(with node: PlayerNode) {
        self.pNode = node
    }
    
    /**
     updates frames
     */
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = seconds
        }
        
        //if state is active
        if activeTime >= 0 {
            activeTime = activeTime - lastUpdateTime
            if (activeTime <= 0.3 && activeTime >= 0.1) {
                if (pNode?.hitBox == nil) {
                    //set hit box
                    pNode?.setHitbox(size: CGSize(width: 25, height: 30))
                    pNode?.hitBox?.xHit = 2.0 * -(pNode?.facing)!
                    pNode?.hitBox?.hitStun = 30
                    
                }
            } else {
                if (pNode?.hitBox != nil){
                    //removes the hitbox
                    pNode?.hitBox?.removeFromParent()
                    pNode?.hitBox = nil
                }
            }
            
        } else {
            //if not attacking state is idle
            pNode?.attack = false
            stateMachine?.enter(DamageState.self)
            activeTime = 0.4
        }
        
        self.lastUpdateTime = seconds
    }
}
