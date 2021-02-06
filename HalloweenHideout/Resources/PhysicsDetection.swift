//
//  PhysicsDetection.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 2/3/21.
//

import SpriteKit
import GameplayKit

struct ColliderType {
    static let PLAYER : UInt32 = 0x1 << 0 //1
    static let GROUND : UInt32 = 0x1 << 1 //2
    //static let CANDY : UInt32 = 0x1 << 2 //3
    
    
}

class PhysicsDetection : NSObject, SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == ColliderType.PLAYER | ColliderType.GROUND {
            if let player = contact.bodyA.node as? PlayerNode {
                player.grounded = true
            } else if let player = contact.bodyB.node as? PlayerNode {
                player.grounded = true
            }
        }
    }
}
