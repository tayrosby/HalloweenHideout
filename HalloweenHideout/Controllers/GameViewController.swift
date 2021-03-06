//
//  GameViewController.swift
//  HalloweenHideout
//
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    /**
     loads the scene
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

