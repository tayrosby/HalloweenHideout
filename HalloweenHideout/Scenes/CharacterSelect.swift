//
//  CharacterSelect.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class CharacterSelect : SKScene {
    /* UI Connections */
    var buttonSelect: ButtonController!

    var player : PlayerNode?
    
        override func didMove(to view: SKView) {

            /* Set UI connections */
            buttonSelect = self.childNode(withName: "buttonSelect") as? ButtonController
            
            buttonSelect.selectedHandler = {
                self.startGame()
            }
        }

    /**
     checks for touches on the screen
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
            //sets the location of the touches
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
        
            switch touchedNode {
            //deselects the character
            case is CharacterSelect:
                player?.character = ""
                touchedNode.removeAllActions()
            case is SKSpriteNode:
                //selects the first character
                if touchedNode.name == "Character1" {
                    player?.character = "Character1"
                    //tells the user which character is selected
                    touchedNode.drawBorder(color: UIColor.systemRed, width: 75)
                }
                //selects the second character
                if touchedNode.name == "Character2" {
                    player?.character = "Character2"
                    //tells the user which character is selected
                    touchedNode.drawBorder(color: UIColor.systemRed, width: 2)
                }
            default:
                ()
        }
    }

    /**
     loads the game scene
     */
    func startGame(){
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
}

/**
 draws a border around the node
 */
extension SKNode {
    func drawBorder(color: UIColor, width: CGFloat) {
        //creates the shape
        let shapeNode = SKShapeNode(rect: CGRect(x: -300, y: -300, width: 600, height: 600))
        //sets the line width, fill color, and stroke colot
        shapeNode.fillColor = .clear
        shapeNode.strokeColor = color
        shapeNode.lineWidth = width
        //adds the node to the scene
        addChild(shapeNode)
    }
}
