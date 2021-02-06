//
//  DamageState.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 2/5/21.
//

import SpriteKit
import GameplayKit

class DamageState : GKState {
    
    var pNode:PlayerNode?
    
    init(with node: PlayerNode) {
        self.pNode = node
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        pNode?.hSpeed = approach(start: (pNode?.hSpeed)!, end: 0, shift: 0.1)
        pNode?.hitStun = (pNode?.hitStun)! - 1
        
        if (pNode?.hitStun)! <= 0 {
            pNode?.hSpeed = 0
            pNode?.physicsBody?.velocity.dx = 0.0
            self.stateMachine?.enter(IdleState.self)
        }
        
        pNode?.xScale = approach(start: (pNode?.xScale)!, end: (pNode?.facing)!, shift: 0.07)
        pNode?.yScale = approach(start: (pNode?.yScale)!, end: 1 , shift: 0.07)

        pNode?.position.x = (pNode?.position.x)! + (pNode?.hSpeed)!
        
        pNode?.hurtBox?.position = CGPoint(x: (pNode?.hurtBox?.xOffset)!, y: (pNode?.hurtBox?.yOffset)!)
    }
    
    func approach(start: CGFloat, end: CGFloat, shift: CGFloat) -> CGFloat{
        if(start < end) {
            return min(start + shift, end)
        } else {
            return max(start - shift, end)
        }
    }
}
