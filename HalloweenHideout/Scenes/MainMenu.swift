//
//  MainMenu.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 1/12/21.
//

import SpriteKit

class MainMenu: SKScene {
    
    var gameViewController : GameViewController?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (gameViewController != nil){
            gameViewController?.startGame()
        }
    }
    
}
    
