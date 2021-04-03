//
//  AnimationController.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class AnimationController : GKComponent {
    
    var pNode : PlayerNode?
    
    @GKInspectable public var characterType = 1
    
    //animation names and actions
    var actions = [String : SKAction]()
    var actionNames : [String : String] = [
        "Idle":"Idle", "Run":"Run", "Jump":"Jump","Falling":"Falling","Damage":"Damage",
        "Attack":"Attack", "Dead":"Dead"
    ]
    
    static private var secureCoding = true
    
    override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        characterType = updateCharacterType()
        
        var prefix = ""
        
        if (characterType == 2) {
            prefix = "Enemy"
        } else if (characterType == 3) {
            prefix = "Costume"
        }
        
        for name in actionNames {
            if name.key == "Idle" || name.key == "Damage" || name.key == "Dead" || name.key == "Attack" || name.key == "Falling" || name.key == "Jump" || name.key == "Run"{
                actionNames[name.key] = "\(prefix)\(name.value)"
            }
            
            actions[name.key] = SKAction(named: actionNames[name.key]!)
        }
    }
    
    func updateCharacterType() -> Int {
        if pNode == nil {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                pNode = nodeComponent.node as? PlayerNode
                characterType = pNode!.characterType
                
            }
        }
        return characterType
    }
    
    override public class var supportsSecureCoding: Bool { return secureCoding }
    
    /**
     updates the frames
     */
    override func update(deltaTime seconds: TimeInterval) {
        
        super.update(deltaTime: seconds)
        
        //sets the nodes
        if pNode == nil {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                pNode = nodeComponent.node as? PlayerNode
            }
        }
        
        //checks if user is in the air
        if (pNode?.grounded)! && ((pNode?.physicsBody?.velocity.dy)! < -20.0) {
            pNode?.grounded = false
        }
        
        //plays idle or run animation
        if pNode?.state?.currentState is IdleState {
            if (pNode?.grounded)! {
                if (pNode?.left)! || (pNode?.right)! {
                    playAnimation(with: "Run")
                } else {
                playAnimation(with: "Idle")
            }
        } else {
            //plays jump animation based on velocity
            if (pNode?.physicsBody?.velocity.dy)! > 10.0 {
                playAnimation(with: "Jump")
                
            } // plays falling animation based on velocity
            else if (pNode?.physicsBody?.velocity.dy)! < 10.0 {
                playAnimation(with: "Falling")
            }
        }
       } //plays attack animation if state is attack
        else if pNode?.state?.currentState is AttackState {
            playAnimation(with: "Attack")

        } // plays damage animation if state is damage
       else if pNode?.state?.currentState is DamageState {
            if pNode?.dead == true {
                playAnimation(with: "Dead")
            } else {
                playAnimation(with: "Damage")
            }
        
       }
}

/**
     plays the animation matching the name
     */
func playAnimation(with name: String) {
    
    if ((pNode?.action(forKey: name)) == nil) {
        pNode?.removeAllActions()
        if (actions[name] != nil) {
            if pNode?.dead == true {
                pNode?.run(actions[name]!, withKey: name)
                pNode?.run(SKAction.wait(forDuration: 1))
                pNode?.removeAction(forKey: "Dead")
                pNode?.texture = SKTexture(imageNamed: "Satyr_01_Dying_014")
            } else {
                pNode?.run(actions[name]!, withKey: name)
            }
        }
    }
}


}


