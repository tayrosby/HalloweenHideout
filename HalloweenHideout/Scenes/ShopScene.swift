//
//  ShopScene.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

extension SKNode {
    func addChildren(_ nodes: [SKNode]) { for node in nodes {addChild(node)}}
    
    func addChildrenBehind(_ nodes: [SKNode]) {for node in nodes {
    node.zPosition -= 2
    addChild(node)
    }}
}

func halfHeight(_ node: SKNode) ->  CGFloat { return node.frame.size.height/2 }
func halfWidth(_ node: SKNode) -> CGFloat { return node.frame.size.width/2 }

class ShopScene: SKScene{
    
    lazy var shop : Shop = { return Shop(shopScene: self) }()
    
    var previousGameScene: GameScene?
    
    var player : PlayerNode? { return self.previousGameScene?.player }
    var costumeNodes = [CostumeNode]()
    
    let buyNode = SKLabelNode(fontNamed: "Chalkduster")
    let candyNode = SKLabelNode(fontNamed: "Chalkduster")
    let exitNode = SKLabelNode(fontNamed: "Chalkduster")
    
    lazy var selectedNode : CostumeNode? = {
        return self.costumeNodes.first!
    }()
    
    var allCostumes: [Costume] = [ Costume(name: "Evil Wizard", texture: SKTexture(imageNamed: "1_Fallen_Angels_Falling Down_000"), price: 25, description: "evil wizard")    ]
    
    /**
     sets up the nodes for the scene
     */
    func setUpNodes() {
        
        //buy label attributes
        buyNode.text = "Buy Costume"
        buyNode.name = "buyNode"
        buyNode.position.y = frame.minY + halfHeight(buyNode)
        
        //candy label attributes
        candyNode.text = "Candy: \(player?.candyAmount ?? 0 )"
        candyNode.name = "candyNode"
        candyNode.position = CGPoint(x: frame.minX + halfWidth(candyNode), y: frame.minY + halfHeight(candyNode))
        
        //exit label attributes
        exitNode.text = "Leave Shop"
        exitNode.name = "exitNode"
        exitNode.position.y = frame.maxY - buyNode.frame.height
        
        //set up the costume nodes
        setUpCostumeNodes: do {
            //add costume to costume nodes
            for costume in allCostumes {
                costumeNodes.append(CostumeNode(costume: costume, player: player))
            }
            
            let offset = CGFloat(150)
            
            /**
             find the starting point to position the costumes
             */
            func findStartingPosition(offset: CGFloat, yPos: CGFloat) -> CGPoint {
                let count = CGFloat(costumeNodes.count)
                let totalOffsets = (count - 1) * offset
                let textureWidth = Costume.list.default_costume.texture.size().width
                let totalWidth = (textureWidth * count) + totalOffsets
                
                let measurementNode = SKShapeNode(rectOf: CGSize(width: totalWidth, height: 0))
                
                return CGPoint(x: measurementNode.frame.minX + textureWidth/2, y: yPos)
            }
            
            costumeNodes.first?.position = findStartingPosition(offset: offset, yPos: self.frame.midY)
            
            var counter = 1
            let finalIndex = costumeNodes.count - 1
            
            while counter <= finalIndex {
                let thisNode = costumeNodes[counter]
                let prevNode = costumeNodes[counter - 1]
                
                thisNode.position.x = prevNode.frame.maxX + halfWidth(thisNode) + offset
                counter += 1
            }
        }
        
        //adds node to the scene
        addChildren(costumeNodes)
        addChildren([buyNode, candyNode, exitNode])
    }
    
    init(previousGameScene: GameScene) {
        self.previousGameScene = previousGameScene
        super.init(size: previousGameScene.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setUpNodes()
        
        //selects the first costume in the array
        select(costumeNodes.first!)
        //for node in costumeNodes {
//            print((player))
//            if node.costume! == (player?.costume)!
//            {
//                select(node)
//            }
        //}
    }
    
    /**
     deselects the costume
     */
    func unselect(_ costumeNode: CostumeNode) {
        selectedNode = nil
        costumeNode.becomesUnselected()
    }
    
    /**
     selects the costume
     */
    func select(_ costumeNode: CostumeNode) {
        unselect(selectedNode!)
        selectedNode = costumeNode
        costumeNode.becomesSelected()
        
        //checks if the user can afford the costume
        if player?.candyAmount ?? 0 < costumeNode.costume!.price {
            buyNode.text = "Can't Afford Costume"
        } else {
            buyNode.text = "Buy Costume"
        }
    }
    
    /**
     checks for touches on the scene
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
            guard let selectedNode = selectedNode else { fatalError() }
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            switch touchedNode {
            case is ShopScene:
                return
            case is SKLabelNode:
                //leaves the store
                if touchedNode.name == "exitNode" { view!.presentScene(previousGameScene)}
                
                //buys the costume
                if touchedNode.name == "buyNode" {
                    if shop.canSellCostume(selectedNode.costume!) {
                        shop.sellCostume(selectedNode.costume!)
                        candyNode.text = "Candy: \(player!.candyAmount)"
                        buyNode.text = "Bought Costume"
                    }
                }
                
            //selects the costume
            case let selectedCostume as CostumeNode:
                for node in costumeNodes {
                    if node.name == selectedCostume.name {
                        select(selectedCostume)
                    }
                }
            default:
                ()
            }
    }
}
