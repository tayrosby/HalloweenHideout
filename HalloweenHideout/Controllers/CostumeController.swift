//
//  CostumeController.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class CostumeController : GKComponent {
    
    static private var secureCoding = true
    var pNode : PlayerNode?
    
    
    /**updates the frames*/
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        //sets the node
        if (pNode == nil) {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                pNode = nodeComponent.node as? PlayerNode
                pNode?.setUpStatemachine()
                pNode?.setHurtbox(size: CGSize(width: 15, height: 20))
                
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
