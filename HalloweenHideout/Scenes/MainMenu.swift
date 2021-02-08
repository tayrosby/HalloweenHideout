//
//  MainMenu.swift
//  HalloweenHideout
//
//

import SpriteKit

class MainMenu: SKScene {
    
    var gameViewController : GameViewController?
    
    /**
     set up touches for starting a game
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (gameViewController != nil){
            gameViewController?.startGame()
        }
    }
    
}
    
