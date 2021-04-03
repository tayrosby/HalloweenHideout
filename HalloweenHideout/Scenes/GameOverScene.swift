//
//  GameOverScene.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class GameOverScene: SKScene {
    var buttonReplay: ButtonController!
    var buttonMenu: ButtonController!
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */

        /* Set UI connections */
        buttonReplay = self.childNode(withName: "buttonReplay") as? ButtonController
        buttonMenu = self.childNode(withName: "buttonMenu") as? ButtonController
        
        buttonReplay.selectedHandler = {
            self.replayGame()
        }
        
        buttonMenu.selectedHandler = {
            self.backToMenu()
        }
        
    }
        
        /**
         navigates to the select game menu
         */
        func replayGame(){
            if let scene = GKScene(fileNamed: "GameScene") {
                if let sceneNode = scene.rootNode as! GameScene? {
              
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
         navigates to the menu scene
         */
        func backToMenu() {
            if let scene = GKScene(fileNamed: "MainMenu") {
                if let sceneNode = scene.rootNode as! MainMenu? {
              
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
