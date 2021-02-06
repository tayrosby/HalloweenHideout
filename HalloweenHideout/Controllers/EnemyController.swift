//
//  EnemyController.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 2/5/21.
//

import SpriteKit
import GameplayKit

class EnemyController : GKComponent {
    
    static private var secureCoding = true
    var pNode : PlayerNode?
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
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
            pNode?.state?.update(deltaTime: seconds)
        }

    }
    
    
    override public class var supportsSecureCoding: Bool { return secureCoding }
    
}
