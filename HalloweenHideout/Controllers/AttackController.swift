//
//  AttackController.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 2/5/21.
//

import SpriteKit
import GameplayKit

class AttackController : GKComponent {
    static private var secureCoding = true
    var pNode : PlayerNode?
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if (pNode == nil) {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                pNode = nodeComponent.node as? PlayerNode
            }
    }
        if pNode?.state?.currentState is AttackState {
            if pNode?.hitBox != nil {
                if let scene = pNode?.parent as! GameScene? {
                    for enemy in scene.enemies {
                        if (pNode?.hitBox?.intersects((enemy.hurtBox)!))! {
                            if !(pNode?.hitBox?.ignoreList.contains((enemy.hurtBox)!))! {
                                pNode?.hitBox?.ignoreList.append((enemy.hurtBox)!)
                                enemy.hitBY = pNode?.hitBox
                                enemy.hit = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    override public class var supportsSecureCoding: Bool { return secureCoding }
    
}
