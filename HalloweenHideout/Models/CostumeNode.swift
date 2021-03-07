//
//  CostumeNode.swift
//  HalloweenHideout
//
//

import SpriteKit

class CostumeNode: SKSpriteNode {
    
    var costume : Costume?
    
    var player : PlayerNode?
    var backgroundNode = SKSpriteNode()
    var nameNode = SKLabelNode()
    var priceNode = SKLabelNode()
    
    /**
     sets label text
     */
    func label(text: String, size:CGSize) -> SKLabelNode {
        let label = SKLabelNode(text: text)
        label.fontName = "Chalkduster"
        return label
    }
    
    init(costume: Costume, player: PlayerNode?) {
        
        /**
         sets the nodes
         */
        func setupNodes(with size: CGSize) {
            
            let circle = SKShapeNode(circleOfRadius: size.width)
            circle.fillColor = .yellow
            let bkg = SKSpriteNode(texture: SKView().texture(from: circle))
            bkg.zPosition -= 1
            
            let name = label(text: "\(costume.name)", size: size)
            name.position.y = frame.maxY + name.frame.size.height
            
            let price = label(text: "\(costume.price)", size: size)
            price.position.y = frame.minY - price.frame.size.height
            
            addChildrenBehind([bkg, name, price])
            (backgroundNode, nameNode, priceNode) = (bkg, name, price)
        }
        
        self.player = player
        self.costume = costume
        
        let size = costume.texture.size()
        super.init(texture: costume.texture, color: .clear, size: size)
        
        name = costume.name   // Name is needed for sorting and detecting touches.
        
        setupNodes(with: size)
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
        backgroundNode.run(.fadeAlpha(to: 0.75, duration: 0.25))
        setPriceText()
        //insert sound
    }

    /**
     deselect costume and set price
     */
    func becomesUnselected() {
        backgroundNode.run(.fadeAlpha(to: 0, duration: 0.10))
        setPriceText()
        // insert sound
    }
}
