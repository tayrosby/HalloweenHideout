//
//  ShopScene.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class ShopScene: SKScene{
    
    var costumeScene: CostumeScene?
    var player : PlayerNode?
    var candyNode : SKLabelNode?
    
    override func didMove(to view: SKView) {
        if let theCandyLabel = self.childNode(withName: "candyNode") {
            candyNode = theCandyLabel as? SKLabelNode
            if (candyNode != nil) {
                let candyLabelAmount = UserDefaultsManager.shared.getPlayerTotalCandyAmount()
                print(candyLabelAmount)
                candyNode?.text = "\(candyLabelAmount)"
            }
            
        }
        
    }
    
    func sendToCostumeScene(nodeName: String) {
        costumeScene?.nodeName = nodeName
        
        // Load the SKScene from ' Costume.sks'
        if let scene = GKScene(fileNamed: "CostumeScene") {
            
            if let sceneNode = scene.rootNode as! CostumeScene? {
                
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.showsPhysics = true
                }
            }
        }
        
    }
    
    /**
     checks for touches on the scene
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)
        
        switch touchedNode {
        case is ShopScene:
            return
        case is SKLabelNode:
            //leaves the store
            if touchedNode.name == "exitNode" {
                // Load the SKScene from 'MainMenu.sks'
                if let scene = GKScene(fileNamed: "MainMenu") {
                    
                    if let sceneNode = scene.rootNode as! MainMenu? {
                        
                        
                        // Set the scale mode to scale to fit the window
                        sceneNode.scaleMode = .aspectFill
                        
                        // Present the scene
                        if let view = self.view as! SKView? {
                            
                            view.presentScene(sceneNode)
                            
                            view.ignoresSiblingOrder = true
                            
                            view.showsFPS = true
                            view.showsNodeCount = true
                            view.showsPhysics = true
                        }
                    }
                }
                
            }
            
        case is SKSpriteNode:
            
            if touchedNode.name == "costume1" {
                sendToCostumeScene(nodeName: touchedNode.name!)
                
            }
            
            if touchedNode.name == "costume2" {
                sendToCostumeScene(nodeName: touchedNode.name!)
            }
            
            if touchedNode.name == "costume3" {
                sendToCostumeScene(nodeName: touchedNode.name!)
            }
        default:
            ()
        }
    }
}
