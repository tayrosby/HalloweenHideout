//
//  AttackState.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 2/5/21.
//

import SpriteKit
import GameplayKit

class AttackState : GKState {
    var pNode : PlayerNode?
    
    var activeTime = 1.1
    private var lastUpdateTime : TimeInterval = 0
    
    
    
    init(with node: PlayerNode) {
        self.pNode = node
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = seconds
        }
        
        if activeTime >= 0 {
            activeTime = activeTime - lastUpdateTime
            if (activeTime <= 1.0 && activeTime >= 0.1) {
                if (pNode?.hitBox == nil) {
                    pNode?.setHitbox(size: CGSize(width: 25, height: 30))
                    pNode?.hitBox?.xHit = 2.0 * -(pNode?.facing)!
                    pNode?.hitBox?.hitStun = 30
                    
                }
            } else {
                if (pNode?.hitBox != nil){
                    pNode?.hitBox?.removeFromParent()
                    pNode?.hitBox = nil
                }
            }
            
        } else {
            pNode?.attack = false
            stateMachine?.enter(IdleState.self)
            activeTime = 1.1
        }
        
        self.lastUpdateTime = seconds
    }
}
