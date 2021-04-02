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
    static let SIGN : UInt32 = 0x1 << 4
}

class PhysicsDetection : NSObject, SKPhysicsContactDelegate {
    
    /**
     detecs the collion based on contact
     */
    func didBegin(_ contact: SKPhysicsContact) {
        
        //collision for character and floor
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ColliderType.PLAYER | ColliderType.GROUND {
            //sets grounded to true if collision between player and ground happened
            if let player = contact.bodyA.node as? PlayerNode {
                player.grounded = true
            } else if let player = contact.bodyB.node as? PlayerNode {
                player.grounded = true
            }
        }
        
        //collision for candy and player
        let collision2: UInt32 = 10
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
        
        //collision for player and the sign
        let collision3: UInt32 = 18
        if collision3 == ColliderType.PLAYER | ColliderType.SIGN {
            //sets collected to true if collision between player and sign happened
            if let sign = contact.bodyA.node as? SignNode {
                sign.readSign = true
                print("1 \(sign.readSign)")
            } else if let sign = contact.bodyB.node as? SignNode {
                sign.readSign = true
                print("2 \(sign.readSign)")
            }
        }
    }
}
