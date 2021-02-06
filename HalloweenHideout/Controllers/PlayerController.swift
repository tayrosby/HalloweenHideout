//
//  PlayerController.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 2/3/21.
//

import GameplayKit
import SpriteKit

class PlayerController: GKComponent, ControlInputDelagate {
    
    var touchControlNode : TouchController?
    var pNode : PlayerNode?
    static private var secureCoding = true
    
    
    func setUpControls(camera : SKCameraNode, scene: SKScene) {
        touchControlNode = TouchController(frame: scene.frame)
        touchControlNode?.inputDelegate = self
        touchControlNode?.position = CGPoint.zero
        
        camera.addChild(touchControlNode!)
        
        if (pNode == nil) {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                pNode = nodeComponent.node as? PlayerNode
            }
        }
    }
    
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
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        pNode?.state?.update(deltaTime: seconds)
    }
}
