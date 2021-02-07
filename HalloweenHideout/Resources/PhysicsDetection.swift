//
//  PhysicsDetection.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 2/3/21.
//

import SpriteKit
import GameplayKit

struct ColliderType {
    static let PLAYER : UInt32 = 0x1 << 1
    static let GROUND : UInt32 = 0x1 << 2
    static let CANDY : UInt32 = 0x1 << 3
    
    
}

class PhysicsDetection : NSObject, SKPhysicsContactDelegate {
    
    var candyStuff : CandyNode?
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        //print(contact.bodyB.categoryBitMask)
        if collision == ColliderType.PLAYER | ColliderType.GROUND {
            if let player = contact.bodyA.node as? PlayerNode {
                player.grounded = true
                //print("Collision ground")

            } else if let player = contact.bodyB.node as? PlayerNode {
                player.grounded = true
               // print("Collision ground")

            }
        }
        //print("out of firdt ]ot")
        let collision2 = 10
        //print(ColliderType.CANDY)
        if collision2 == ColliderType.PLAYER | ColliderType.CANDY {
            //print("in second loop")
            if let candy = contact.bodyA.node as? CandyNode {
                candy.collected = true
                print(candy.collected )
                candy.removeFromParent()
               // print("collision candy")
            } else if let candy = contact.bodyB.node as? CandyNode {
                candy.collected = true
                print(candy.collected)
                candy.removeFromParent()
               // print("collision candy")
            }
        }
  
    }
}
