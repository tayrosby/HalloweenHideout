//
//  Shop.swift
//  HalloweenHideout
//
//

import SpriteKit

class Shop {
    
    var scene : ShopScene?
    var player : PlayerNode { return scene!.player!}
    var availableCostumes: [Costume] = [Costume.list.eviler_wizard, Costume.list.evil_wizard]
    var soldCostumes: [Costume] = [Costume.defaultCostume]
    
    /**
     checks if a costume can be sold
     */
    func canSellCostume(_ costume: Costume) -> Bool {
        if player.candyAmount < costume.price { return false }
        else if player.hasCostume(costume) { return false }
        else if player.costume! == costume { return false }
        else { return true }
    }
    
    /**
     sells the costume to the player
     */
    func sellCostume(_ costume: Costume) {
        player.loseCandy(costume.price)
        player.getCostume(costume)
    }
    
    /**
     add costumes to the shop
     */
    func newCostumeBecomesAvailable(_ costume: Costume) {
        if availableCostumes.contains(where: {$0.name == costume.name}) {
            fatalError()
        } else {
            availableCostumes.append(costume)
        }
    }
    
    init(shopScene: ShopScene) {
        self.scene = shopScene
    }
    
}
