//
//  PlayerController.swift
//  HalloweenHideout
//
//

import GameplayKit
import SpriteKit

class PlayerController: GKComponent, ControlInputDelagate {
    
    var touchControlNode : TouchController?
    var pNode : PlayerNode?
    static private var secureCoding = true
    
    /**
     
     adds the controls to the player
     */
    func setUpControls(camera : SKCameraNode, scene: SKScene) {
        touchControlNode = TouchController(frame: scene.frame)
        touchControlNode?.inputDelegate = self
        touchControlNode?.position = CGPoint.zero
        
        //add the controllers to the camera
        camera.addChild(touchControlNode!)
        
        //if player is empty set one
        if (pNode == nil) {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                pNode = nodeComponent.node as? PlayerNode
            }
        }
    }
    
    /**
     sets player properties depending on touch input
     */
    func follow(command: String?) {
        if (pNode != nil) {
            switch (command!){
            case ("left"):
                pNode?.left = true
            case ("stop left"):
                pNode?.left = false
            case ("right"):
                pNode?.right = true
            case ("stop right"):
                pNode?.right = false
            case ("A"):
                pNode?.jump = true
            case ("stop A"):
                pNode?.jump = false
            case ("B"):
                pNode?.attack = true
            case ("stop B"):
                pNode?.attack = false
            default:
                print("command: \(String(describing: command))")
            }
            
        }
    }
    
    override public class var supportsSecureCoding: Bool { return secureCoding }
    
    /**
     updates the frames
     */
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        //update the state of the player
        pNode?.state?.update(deltaTime: seconds)
    }
}
