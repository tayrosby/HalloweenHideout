//
//  GameViewController.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 12/8/20.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the SKScene from 'GameScene.sks'
        if let scene = GKScene(fileNamed: "GameScene") {
            
            if let sceneNode = scene.rootNode as! GameScene? {
                
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
            
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
    
    func presentMainMenu(){
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "MainMenu") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                if let sceneNode = scene as? MainMenu{
//                    sceneNode.gameViewController = self
//                }
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
    }

    func startGame(){
//        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
//        // including entities and graphs.
//        if let scene = GKScene(fileNamed: "GameScene") {
//
//            // Get the SKScene from the loaded GKScene
//            if let sceneNode = scene.rootNode as! GameScene? {
//
//                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
//                sceneNode.gameViewController = self
//                sceneNode.size = self.view.bounds.size
//                // Set the scale mode to scale to fit the window
//                sceneNode.scaleMode = .aspectFill
//
//
//                // Present the scene
//                if let view = self.view as! SKView? {
//                    view.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 0.5))
//
//                    view.ignoresSiblingOrder = true
//
//                    view.showsFPS = true
//                    view.showsNodeCount = true
//                    view.showsPhysics = true
//                }
//            }
//        }
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
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Release any cached data, images, etc that aren't in use.
//    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//    func saveCheckpoint(position: CGPoint?){
//       // playerPosition = position
//    }
}
    
    //    //sets the default size of the scene
//    let scene = GameScene(size: CGSize(width: 2436, height: 1125))
//
//    /*
//     loads the scene
//     */
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //maps the scene to the presentation view
//        scene.scaleMode  = .aspectFit
//
//        let skView = view as! SKView
//        //shows the frames per second
//        skView.showsFPS = true
//
//        //shows the amount of nodes
//        skView.showsNodeCount = true
//        skView.showsPhysics = true
//        skView.ignoresSiblingOrder = true
//        skView.presentScene(scene)
//
//}
//

