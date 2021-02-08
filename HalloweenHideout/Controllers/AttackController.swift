//
//  AttackController.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class AttackController : GKComponent {
    static private var secureCoding = true
    var pNode : PlayerNode?
    
    /**
     updates the frames
     */
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        //sets the node
        if (pNode == nil) {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                pNode = nodeComponent.node as? PlayerNode
            }
    }
        //set the state to attack
        if pNode?.state?.currentState is AttackState {
            if pNode?.hitBox != nil {
                if let scene = pNode?.parent as! GameScene? {
                    for enemy in scene.enemies {
                        if (pNode?.hitBox?.intersects((enemy.hurtBox)!))! {
                            if !(pNode?.hitBox?.ignoreList.contains((enemy.hurtBox)!))! {
                                pNode?.hitBox?.ignoreList.append((enemy.hurtBox)!)
                                enemy.hitBY = pNode?.hitBox
                                enemy.hit = true
                                enemy.health = 0.0
                                if enemy.health == 0.0 {
                                    enemy.dead = true
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    override public class var supportsSecureCoding: Bool { return secureCoding }
    
}
