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
            // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
            // including entities and graphs.
            if let scene = GKScene(fileNamed: "GameScene") {

                // Get the SKScene from the loaded GKScene
                if let sceneNode = scene.rootNode as! GameScene? {

                    // Copy gameplay related content over to the scene
                    sceneNode.entities = scene.entities
                    sceneNode.graphs = scene.graphs
                    //sceneNode.gameViewController = self
                    sceneNode.size = self.view!.bounds.size
                    // Set the scale mode to scale to fit the window
                    sceneNode.scaleMode = .aspectFill


                    // Present the scene
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
