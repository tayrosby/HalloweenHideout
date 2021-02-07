//
//  CandyController.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 2/6/21.
//

import GameplayKit
import SpriteKit

class CandyController : GKComponent {
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
                    for candy in scene.candies {
                        if (pNode?.hitBox?.intersects((candy.hurtBox)!))! {
                            if !(pNode?.hitBox?.ignoreList.contains((candy.hurtBox)!))! {
                                pNode?.hitBox?.ignoreList.append((candy.hurtBox)!)
                                candy.hitBY = pNode?.hitBox
                                candy.collected = true
                                candy.removeFromParent()
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    override public class var supportsSecureCoding: Bool { return secureCoding }
}
