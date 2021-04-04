//
//  EnemyController.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class EnemyController : GKComponent {
    
    static private var secureCoding = true
    var pNode : PlayerNode?
    
    /**
     checks the enemy health
     */
    func isDead(health : CGFloat) {
        if pNode?.health == 0.0 {
            pNode?.dead = true;
        }
    }
    
    /**
     updates the frames
     */
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        //sets the node
        if (pNode == nil) {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                pNode = nodeComponent.node as? PlayerNode
                pNode?.setUpStatemachine()
                pNode?.setHurtbox(size: CGSize(width: 20.0, height: 35))
                
                if let parentScene = pNode?.parent as? GameScene {
                    parentScene.enemies.append(pNode!)
                }
            }
        } else {
            //update player state
            pNode?.state?.update(deltaTime: seconds)
        }

    }
    
    
    override public class var supportsSecureCoding: Bool { return secureCoding }
    
}
