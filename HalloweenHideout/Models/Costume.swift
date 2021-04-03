//
//  Costume.swift
//  HalloweenHideout
//
//

import SpriteKit

class Costume {
    
    let name: String
    let texture: SKTexture
    var price: CGFloat
    let description: String
    
    static var allCostumes = [Costume]()
    
    init(name:String, texture:SKTexture, price:CGFloat, description:String) {
        self.name = name
        self.texture = texture
        self.price = price
        self.description = description
    }

    static let list = (
        hero_knight: Costume(name: "Hero Knight", texture: SKTexture(imageNamed: "hero_costume_idle00"), price: 0, description: "evil wizard"),
        martial_hero: Costume(name: "Martial Hero", texture: SKTexture(imageNamed: "martial_costume_idle0"), price: 0, description: "eviler wizard"),
        fantasy_warrior: Costume(name: "Fanatsy Warrior", texture: SKTexture(imageNamed: "warrior_costume_idle_00"), price: 0, description: "fantasy warrior"),
        default_costume: Costume(name: "default", texture: SKTexture(imageNamed: "1_Fallen_Angels_Idle Blinking_000"), price: 0, description: "default")
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


