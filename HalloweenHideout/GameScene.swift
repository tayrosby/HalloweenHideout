//
//  GameScene.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 12/8/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
   //MARK: - Properties
    
    var ground: SKSpriteNode!
    var player: SKSpriteNode!
    
    /*
     creates a playable area for the character
     */
    //TODO: finish playable area
    var playableRect: CGRect {
        let ratio: CGFloat
        switch UIScreen.main.nativeBounds.height {
        case 2658, 1792, 2436:
            ratio = 2.16
        default:
            ratio = 16/9
        }
        
        //sets the playable height
        let playableHeight = size.width / ratio
        
        //sets the rest of the margins
        let playableMargin = (size.height - playableHeight) / 2.0
        
        return CGRect(x: 0.0, y: playableMargin, width: size.width, height: playableHeight)
    }
    
    //MARK: - Systems
    
    /*
     calls the setup function
     */
    override func didMove(to view: SKView) {
        setUpNodes()
    }
    
    //MARK: - Configuration
    

    /*
     calls the nodes for the level
     */
    func setUpNodes() {
        createBG()
        createGround()
        createPlayer()
    }
    
    /*
     creates background
     */
    func createBG() {
        
        //adds the background image to the screen
        let bg = SKSpriteNode(imageNamed: "1_game_background")
        
        //anchors the background in the lower left corner
        bg.anchorPoint = .zero
        bg.position = .zero
        
        //puts the background on the bottom most layer
        bg.zPosition = -1.0
        addChild(bg)
        
    }
    
    /*
     creates the ground
     */
    func createGround() {
        
        //creates tiles for the player to walk
        for i in 0...14 {
            //Adds the ground to the scene
            let ground = SKSpriteNode(imageNamed: "Tile (2)")
            ground.name = "Ground"
            
            //anchors the ground in the lower left corner of the screen
            ground.anchorPoint = .zero
            
            //puts the ground a layer above the background
            ground.zPosition = 1.0
            
            //puts the ground along the bottom of the screen
            ground.position = CGPoint(x: CGFloat(i)*ground.frame.width, y: 0.0)
            addChild(ground)
            
        }
    }
    
    /*
     creates the player
     */
    func createPlayer() {
        //adds the player image to the scene
        player = SKSpriteNode(imageNamed: "0_Fallen_Angels_Idle Blinking_000")
        player.name = "Player"
        
        //puts the player on the top position layer
        player.zPosition = 5.0
        
        //puts the player in the middle of the scene
        player.position = CGPoint(x: frame.width/2.0 - 100.0, y: 128.0 + player.frame.height/3.0)
        addChild(player)
    }
    
    
    
    
}
