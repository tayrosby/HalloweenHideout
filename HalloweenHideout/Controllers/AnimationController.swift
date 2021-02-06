//
//  AnimationController.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 2/3/21.
//

import SpriteKit
import GameplayKit

class AnimationController : GKComponent {
    
    var pNode : PlayerNode?
    @GKInspectable var characterType = 1
    
    var actions = [String : SKAction]()
    var actionNames : [String : String] = [
        "Idle":"Idle", "Run":"Run", "Jump":"Jump","Faliing":"Falling","Damage":"Damage",
        "Attack":"Attack"
    ]
    
    static private var secureCoding = true
    
    override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        var prefix = ""
        
        if (characterType == 2) {
            prefix = "Enemy"
        }
        
        for name in actionNames {
            if name.key == "Idle" || name.key == "Damage" {
                actionNames[name.key] = "\(prefix)\(name.value)"
            }
            
            actions[name.key] = SKAction(named: actionNames[name.key]!)
        }
    }
    
    override public class var supportsSecureCoding: Bool { return secureCoding }
    
    override func update(deltaTime seconds: TimeInterval) {
        
        if pNode == nil {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                pNode = nodeComponent.node as? PlayerNode
            }
        }
        
       // if (pNode?.grounded)! && ((pNode?.physicsBody?.velocity.dy)! < -20.0) {
           // pNode?.grounded = false
        //}
        
        if pNode?.state?.currentState is IdleState {
            if (pNode?.grounded)! {
                if (pNode?.left)! || (pNode?.right)! {
                    playAnimation(with: "Run")
                }
             else {
                playAnimation(with: "Idle")
            }
        } else {
            
            if (pNode?.physicsBody?.velocity.dy)! > 10.0 {
                playAnimation(with: "Jump")
                
            } else if (pNode?.physicsBody?.velocity.dy)! < 10.0 {
                playAnimation(with: "Faling")
            }
        }
       } else if pNode?.state?.currentState is AttackState {
            playAnimation(with: "Attack")

        } else if pNode?.state?.currentState is DamageState {
            playAnimation(with: "Damage")
        }
}


func playAnimation(with name: String) {
    
    if ((pNode?.action(forKey: name)) == nil) {
        pNode?.removeAllActions()
        if (actions[name] != nil) {
            pNode?.run(actions[name]!, withKey: name)
        }
    }
}


}


