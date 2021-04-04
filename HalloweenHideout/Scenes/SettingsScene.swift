//
//  Settings.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class SettingsScene: SKScene {
    
    var buttonBack: ButtonController!
    
    override func didMove(to view: SKView) {
        //Setup your scene here

        //Set UI connections
        buttonBack = self.childNode(withName: "buttonBack") as? ButtonController
        
        buttonBack.selectedHandler = {
            self.returnToMainMenu()
        }
        
    }
    
    /**
     returns to the main menu
     */
    func returnToMainMenu() {
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
    
}
