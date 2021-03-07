//
//  Costume.swift
//  HalloweenHideout
//
//

import SpriteKit

class Costume {
    
    let name: String
    let texture: SKTexture
    let price: CGFloat
    let description: String
    
    static var allCostumes = [Costume]()
    
    init(name:String, texture:SKTexture, price:CGFloat, description:String) {
        self.name = name
        self.texture = texture
        self.price = price
        self.description = description

        Costume.allCostumes.append(self)
    }

    static let list = (
        evil_wizard: Costume(name: "Evil Wizard", texture: SKTexture(imageNamed: ""), price: 25, description: "evil wizard"),
        eviler_wizard: Costume(name: "Eviler Wizard", texture: SKTexture(imageNamed: ""), price: 25, description: "eviler wizard"),
        fantasy_warrior: Costume(name: "Fanatsy Warrior", texture: SKTexture(imageNamed: ""), price: 50, description: "fantasy warrior"),
        default_costume: Costume(name: "default", texture: SKTexture(imageNamed: ""), price: 50, description: "default")
    )
    
    static let defaultCostume = list.default_costume

    static func == (lhs: Costume, rhs: Costume) -> Bool {
    if lhs.name == rhs.name {
        return true
    } else {
        return false
    }
}

}


