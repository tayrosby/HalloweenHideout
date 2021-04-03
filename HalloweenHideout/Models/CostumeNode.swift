//
//  CostumeNode.swift
//  HalloweenHideout
//
//

import SpriteKit

class CostumeNode: SKSpriteNode {
    
    var costume : Costume?
    
    var player : PlayerNode?
    var nameNode = SKLabelNode()
    var priceNode = SKLabelNode()

    
    init(costume: Costume, player: PlayerNode?) {
        
        self.player = player
        self.costume = costume
        
        let size = costume.texture.size()
        super.init(texture: costume.texture, color: .clear, size: size)
        
        name = costume.name   // Name is needed for sorting and detecting touches.

        becomesUnselected()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     updates price labes
     */
    private func setPriceText() {
        
        func playerCanAfford() {
            priceNode.text = "\(costume?.price ?? 0)"
            priceNode.fontColor = .white
        }
        
        func playerCantAfford() {
            priceNode.text = "\(costume?.price ?? 0)"
            priceNode.fontColor = .red
        }
        
        func playerOwns() {
            priceNode.text = ""
            priceNode.fontColor = .white
        }
        
        //calls above method based on costume and candy amount
        if ((player?.hasCostume(self.costume!)) != nil)         { playerOwns() }
        else if player?.candyAmount ?? 0 < self.costume!.price  { playerCantAfford() }
        else if player?.candyAmount ?? 0 >= self.costume!.price { playerCanAfford()  }
        else                                       { fatalError() }
    }
    
    /**
     select costume and set price
     */
    func becomesSelected() {
        setPriceText()
        //insert sound
    }

    /**
     deselect costume and set price
     */
    func becomesUnselected() {
        setPriceText()
        // insert sound
    }
}
