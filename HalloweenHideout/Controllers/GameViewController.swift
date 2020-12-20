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
    
    //sets the default size of the scene
    let scene = GameScene(size: CGSize(width: 2436, height: 1125))

    /*
     loads the scene
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //maps the scene to the presentation view
        scene.scaleMode  = .aspectFit
        
        let skView = view as! SKView
        //shows the frames per second
        skView.showsFPS = true
        
        //shows the amount of nodes
        skView.showsNodeCount = true
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
        
}
    
    /*
     moves the player left
     */
    func movePlayerLeft(moveBy: CGFloat)
    {
        //moves the player to the left on the x axis
        let moveAction = SKAction.moveBy(x: moveBy, y: 0, duration: 2)
       
        //repeats while the player holds the button
        let held = SKAction.repeatForever(moveAction)
        
        //puts the actions in order
        let seq = SKAction.sequence([moveAction, held])
        
        //runs the sequense
        scene.player.run(seq)
    }
    
    /*
     moves the player to the right
     */
    func movePlayerRight(moveBy: CGFloat) {
        //moves the player to the right on the x axis
        let moveAction = SKAction.moveBy(x: moveBy, y: 0, duration: 2)
        
        //repeats while the player holds the button
        let held = SKAction.repeatForever(moveAction)
        
        //puts the actions in order
        let seq = SKAction.sequence([moveAction, held])
        
        //runs the sequence
        scene.player.run(seq)
    }
    
    /*
     causes the player to jump
     */
    func playerJump(moveUpBy: CGFloat, moveDownBy: CGFloat) {
        //moves the player up on the y axis
        let moveUp = SKAction.moveBy(x: 0, y: moveUpBy, duration: 2)
        
        //repeats the action twice
        let jumpUp = SKAction.repeat(moveUp, count: 2)
        
        //moves the player down on the y axis
        let moveDown = SKAction.moveBy(x: 0, y: moveDownBy, duration: 2)
        
        //repeats the action twice
        let land = SKAction.repeat(moveDown, count: 2)
        
        //puts the actions in a secuence
        let seq = SKAction.sequence([moveUp, jumpUp, moveDown, land])
        
        //runs the sequence
        scene.player.run(seq)
    }
    
    /*
     connects the button to movePlayerLeft
     */
    @IBAction func moveLeft(_ sender: Any) {
        movePlayerLeft(moveBy: -50.0)
    }
    
    /*
     connects the button to movePlayerRight
     */
    @IBAction func moveRight(_ sender: Any) {
        movePlayerRight(moveBy: 50.0)
    }
    
    /*
     connects the button to jumo
     */
    @IBAction func jump(_ sender: Any) {
        playerJump(moveUpBy: 50.0, moveDownBy: -50.0)
    }
}
