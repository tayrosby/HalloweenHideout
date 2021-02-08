//
//  PhysicsDetection.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

//category of objects
struct ColliderType {
    static let PLAYER : UInt32 = 0x1 << 1
    static let GROUND : UInt32 = 0x1 << 2
    static let CANDY : UInt32 = 0x1 << 3
}

class PhysicsDetection : NSObject, SKPhysicsContactDelegate {
    
    /**
     detecs the collion based on contact
     */
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ColliderType.PLAYER | ColliderType.GROUND {
            //sets grounded to true if collision between player and ground happened
            if let player = contact.bodyA.node as? PlayerNode {
                player.grounded = true
            } else if let player = contact.bodyB.node as? PlayerNode {
                player.grounded = true
            }
        }
        
        let collision2: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision2 == ColliderType.PLAYER | ColliderType.CANDY {
            //sets collected to true if collision between player and candy happened and removes candy from scene
            if let candy = contact.bodyA.node as? CandyNode {
                candy.collected = true
                candy.removeFromParent()
            } else if let candy = contact.bodyB.node as? CandyNode {
                candy.collected = true
                candy.removeFromParent()
            }
        }
  
    }
}
