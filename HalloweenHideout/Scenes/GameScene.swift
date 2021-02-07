//
//  GameScene.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 12/8/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var enemies = [PlayerNode]()
    var candies = [CandyNode]()
    var graphs = [String : GKGraph]()
    var physicsDelagate = PhysicsDetection()
    var player : PlayerNode?
    var candy : CandyNode?
    
    private var lastUpdateTime : TimeInterval = 0
    
    var parallaxSystem: GKComponentSystem<ParallaxController>?
    
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        
        parallaxSystem = GKComponentSystem.init(componentClass: ParallaxController.self)
        
        for entity in self.entities {
            parallaxSystem?.addComponent(foundIn: entity)
        }
        
        for component in (parallaxSystem?.components)! {
            component.prepareWith(camera: camera!)
        }
        
        if let theCandy = self.childNode(withName: "Candy") {
            candy = theCandy as? CandyNode
            if (candy != nil) {
                candy?.candyValue = 5
                candy?.createPhysics()
                candy?.setHurtbox(size: CGSize(width: 15, height: 15))
            }
        }
        
//        if let candyLabel = camera?.childNode(withName: "CandyLabel") as? SKLabelNode {
//            updateCandyLabel(label: candyLabel)
//        }
        
        
        if let thePlayer = childNode(withName: "Player") {
            player = thePlayer as? PlayerNode
            if (player != nil) {
                player?.setUpStatemachine()
                player?.createPhysics()
                player?.setHurtbox(size: CGSize(width: 25, height: 50))
            }
            if let poComponent = thePlayer.entity?.component(ofType: PlayerController.self){
                poComponent.setUpControls(camera: camera!, scene: self)
            }
        }
        
        if let tileMap = childNode(withName: "ForegroundMap") as? SKTileMapNode {
            giveTileMapPhysics(map: tileMap)
        }
        
        self.physicsWorld.contactDelegate = physicsDelagate

    }
    
    func updateCandyLabel(label: SKLabelNode){
        
        let candyLabel = label
        
        print(candy?.collected)
        
        if (candy?.collected == true) {
            candy?.candyAmount = (candy?.candyAmount)! + (candy?.candyValue)!
            
            candyLabel.text = "\(candy?.candyAmount ?? 0)"
            //candy?.removeFromParent()
            //candy?.collected = false
        }
    }
    
    
    func giveTileMapPhysics(map: SKTileMapNode) {
        let tileMap = map
        
        let tileSize = tileMap.tileSize
        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width
        let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height
        
        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row) {
                    let isEdgeTile = tileDefinition.userData?["AddBody"] as? Int
                    if (isEdgeTile != 0) {
                        let tileArray = tileDefinition.textures
                        let tileTexture = tileArray[0]
                        let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width/2)
                        let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height/2)
                        _ = CGRect(x: 0, y: 0, width: tileSize.width, height: tileSize.height)
                        let tileNode = SKNode()
                        
                        tileNode.position = CGPoint(x: x, y: y)
                        
                        tileNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (tileTexture.size().width), height: (tileTexture.size().height)))
                        tileNode.physicsBody?.linearDamping = 0
                        tileNode.physicsBody?.affectedByGravity = false
                        tileNode.physicsBody?.allowsRotation = false
                        tileNode.physicsBody?.restitution = 0
                        tileNode.physicsBody?.isDynamic = false
                        tileNode.physicsBody?.friction = 20.0
                        tileNode.physicsBody?.mass = 30.0
                        tileNode.physicsBody?.contactTestBitMask = 0
                        tileNode.physicsBody?.fieldBitMask = 0
                        tileNode.physicsBody?.collisionBitMask = 0
                        
                        //makes it so no fall through ground
                        if (isEdgeTile == 1) {
                            tileNode.physicsBody?.restitution = 0.0
                            tileNode.physicsBody?.contactTestBitMask = ColliderType.PLAYER
                        }
                        
                        tileNode.physicsBody?.categoryBitMask = ColliderType.GROUND
                        tileMap.addChild(tileNode)
                    }
                }
            }
        }
    }
    
    
    func centerOnNode(node: SKNode) {
        self.camera!.run(SKAction.move(to: CGPoint(x: node.position.x, y: node.position.y), duration: 0.5))
    }
    
    override func didFinishUpdate() {
        centerOnNode(node: player!)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //called before each frame is rendered
        
        //initalize _lastUpdateTime if it hasn't been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        if let candyLabel = camera?.childNode(withName: "CandyLabel") as? SKLabelNode {
            updateCandyLabel(label: candyLabel)
            candy?.collected = false
        }
        
        //calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        //update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        parallaxSystem?.update(deltaTime: currentTime)
        
        self.lastUpdateTime = currentTime
    }
}
    
