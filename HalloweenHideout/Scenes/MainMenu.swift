//
//  MainMenu.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class MainMenu: SKScene {
    
    /* UI Connections */
    var buttonPlay: ButtonController!
    var buttonStore: ButtonController!
    var buttonSetting: ButtonController!
    
        override func didMove(to view: SKView) {
            /* Setup your scene here */

            /* Set UI connections */
            buttonPlay = self.childNode(withName: "buttonPlay") as? ButtonController
            buttonStore = self.childNode(withName: "buttonStore") as? ButtonController
            buttonSetting = self.childNode(withName: "buttonSetting") as? ButtonController
            
            buttonPlay.selectedHandler = {
                self.selectCharacter()
            }
            
            buttonStore.selectedHandler = {
                self.enterStore()
            }
            
            buttonSetting.selectedHandler = {
                self.enterSettingsMenu()
            }
            
        }
    
    /**
     navigates to the select character menu
     */
    func selectCharacter(){
        if let scene = GKScene(fileNamed: "CharacterSelect") {
            if let sceneNode = scene.rootNode as! CharacterSelect? {
          
                sceneNode.size = self.view!.bounds.size
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                //present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 0.5))

                    view.ignoresSiblingOrder = true

                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.showsPhysics = true
                }
                
            }
            
        }
        
    }
    
    /**
     navigates to the store scene
     */
    func enterStore() {
        if let scene = GKScene(fileNamed: "ShopScene") {
            if let sceneNode = scene.rootNode as! ShopScene? {
          
                sceneNode.size = self.view!.bounds.size
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                //present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 0.5))

                    view.ignoresSiblingOrder = true

                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.showsPhysics = true
                }
                
            }
            
        }
    }
    
    /**
     navigates to the settings scene
     */
    func enterSettingsMenu() {
        if let scene = GKScene(fileNamed: "SettingsScene") {
            if let sceneNode = scene.rootNode as! SettingsScene? {
          
                sceneNode.size = self.view!.bounds.size
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                //present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 0.5))

                    view.ignoresSiblingOrder = true

                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.showsPhysics = true
                }
                
            }
            
        }
    }
}
    
