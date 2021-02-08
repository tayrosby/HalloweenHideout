//
//  Hitbox.swift
//  HalloweenHideout
//
//

import SpriteKit

class Hitbox : SKSpriteNode {
    
    //hitbox attributes
    
    var image_alpha : CGFloat = 0.5
    var xOffset : CGFloat = 20.0
    var yOffset : CGFloat = -5.0
    var xHit : CGFloat = 0.0
    var yHit : CGFloat = 0.0
    var life : CGFloat = 0.0
    var hitStun : CGFloat = 60
    var ignore = false
    var ignoreList = [Hurtbox]()
    
}
