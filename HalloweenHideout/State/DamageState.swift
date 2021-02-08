//
//  DamageState.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class DamageState : GKState {
    
    var pNode:PlayerNode?
    var cameraNode: SKCameraNode?
    
    //initalizes player
    init(with node: PlayerNode) {
        self.pNode = node
    }
    
    /**
     state change
     */
    override func didEnter(from previousState: GKState?) {
        //set the camera node as the game scene camera
        if cameraNode == nil {
            if let mainScene = pNode?.parent as? SKScene {
                cameraNode = mainScene.camera!
            }
        }
        
        //shake the camera
        if cameraNode != nil {
            let shake = SKAction.shake(initialPosition: (cameraNode?.position)!, duration: 0.8, amplitudeX: 16, amplitudeY: 16)
            cameraNode?.run(shake)
        }
    }
    
    /**
     updates frames
     */
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        pNode?.hSpeed = approach(start: (pNode?.hSpeed)!, end: 0, shift: 0.1)
        pNode?.hitStun = (pNode?.hitStun)! - 1
        
        //enemy stun
        if (pNode?.hitStun)! <= 0 {
            pNode?.hSpeed = 0
            pNode?.physicsBody?.velocity.dx = 0.0
            if pNode?.dead == false {
                self.stateMachine?.enter(IdleState.self)
            } 
        }
        
        //enemy blow back speed
        pNode?.xScale = approach(start: (pNode?.xScale)!, end: (pNode?.facing)!, shift: 0.07)
        pNode?.yScale = approach(start: (pNode?.yScale)!, end: 1 , shift: 0.07)

        //player position
        pNode?.position.x = (pNode?.position.x)! + (pNode?.hSpeed)!
        
        //hurt box position
        pNode?.hurtBox?.position = CGPoint(x: (pNode?.hurtBox?.xOffset)!, y: (pNode?.hurtBox?.yOffset)!)
    }
    
    /**
     player speed
     */
    func approach(start: CGFloat, end: CGFloat, shift: CGFloat) -> CGFloat{
        if(start < end) {
            return min(start + shift, end)
        } else {
            return max(start - shift, end)
        }
    }
}
