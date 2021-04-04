//
//  GameScene.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var enemies = [PlayerNode]()
    var costumes = [PlayerNode]()
    var candies = [CandyNode]()
    var graphs = [String : GKGraph]()
    var physicsDelagate = PhysicsDetection()
    var player : PlayerNode?
    var candy : CandyNode?
    var sign : TutorialSignNode?
    var nextLevelSign : NextLevelSignNode?
    var aLabel : SKLabelNode?
    var bLabel : SKLabelNode?
    var walkLabel :SKLabelNode?
    var signText : SKSpriteNode?
    var costume : CostumeObjectNode?
    var animate : AnimationController?
    
    var gameOver = false
    
    private var lastUpdateTime : TimeInterval = 0
    
    var parallaxSystem: GKComponentSystem<ParallaxController>?
    
    //load the scene
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    /**
     tells when the scene is presented
     */
    override func didMove(to view: SKView) {
        
        //sets the parallax system
        parallaxSystem = GKComponentSystem.init(componentClass: ParallaxController.self)
        
        //adds parallax to the entites
        for entity in self.entities {
            parallaxSystem?.addComponent(foundIn: entity)
        }
        
        //prepares the camera for parallax
        for component in (parallaxSystem?.components)! {
            component.prepareWith(camera: camera!)
        }
        
        //if the node in gamescene == candy set as candy node
        if let theCandy = self.childNode(withName: "Candy") {
            candy = theCandy as? CandyNode
            //if candy exists
            if (candy != nil) {
                //sets value
                candy?.candyValue = 5
                //creates candy physics
                candy?.createPhysics()
            }
        }
        
        if let theSign = self.childNode(withName: "sign_1") {
            sign = theSign as? TutorialSignNode
            
            if (sign != nil) {
                if let signTextPage = self.childNode(withName: "costumeCandySignText") {
                    signText = signTextPage as? SKSpriteNode
                    
                    if (signText != nil) {
                        signText?.isHidden = true
                    }
                }
                
            }
        }
        
        if let theSign = self.childNode(withName: "nextLevelSign") {
            nextLevelSign = theSign as? NextLevelSignNode
        }
        
        if let costumeSign = self.childNode(withName: "CostumeObject") {
            costume = costumeSign as? CostumeObjectNode
        }
        
        //creates pop up for the jump label
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.aLabel = self.childNode(withName: "A_label") as? SKLabelNode
            if let aLabel = self.aLabel {
                aLabel.text = "Press the a button to jump"
                aLabel.run(SKAction.fadeIn(withDuration: 4.0))
                aLabel.run(SKAction.fadeOut(withDuration: 4.0))
            }
        }
        
        //creates pop up for the attack label
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            self.bLabel = self.childNode(withName: "B_Label") as? SKLabelNode
            if let bLabel = self.bLabel {
                bLabel.text = "Press the b button to attack"
                bLabel.run(SKAction.fadeIn(withDuration: 4.0))
                bLabel.isHidden = false
                bLabel.run(SKAction.fadeOut(withDuration: 4.0))
            }
        }
        
        //creates pop up for the run label
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.walkLabel = self.childNode(withName: "Walk_label") as? SKLabelNode
            if let walkLabel = self.walkLabel {
                walkLabel.text = "Press the arrows button to run"
                walkLabel.run(SKAction.fadeIn(withDuration: 4.0))
                walkLabel.isHidden = false
                walkLabel.run(SKAction.fadeOut(withDuration: 4.0))
            }
        }

        //if the node in gamescene == player set as player node
        if let thePlayer = childNode(withName: "Player") {
            player = thePlayer as? PlayerNode
            //if player exists
            if (player != nil) {
                //sets state
                player?.setUpStatemachine()
                //creates player physics
                player?.createPhysics()
                //set hurtbox
                player?.setHurtbox(size: CGSize(width: 25, height: 50))
            }
            
            //prepare the camera with the controls
            if let poComponent = thePlayer.entity?.component(ofType: PlayerController.self){
                poComponent.setUpControls(camera: camera!, scene: self)
            }
        }
        
        //create tile map
        if let tileMap = childNode(withName: "ForegroundMap") as? SKTileMapNode {
            giveTileMapPhysics(map: tileMap)
        }
        
        //calls physics detector
        self.physicsWorld.contactDelegate = physicsDelagate

    }
    
    /**
     updates the candy level
     */
    func updateCandyLabel(label: SKLabelNode){

        let candyLabel = label
        
        //if collected == true update the label
        if (candy?.collected == true) {
            player?.getCandy(candy!.candyValue)
            let candyLabelAmount = UserDefaultsManager.shared.getPlayerLevelCandyAmount()
            print(candyLabelAmount)
            candyLabel.text = "\(candyLabelAmount)"
            candy!.collected = false
            print("candy: \(candy!.collected)")
        }
    }
    
    func openSign(node: SKSpriteNode) {
        if (sign?.readSign == true) {
            node.run(SKAction.fadeIn(withDuration: 6.0))
            node.isHidden = false
            node.run(SKAction.fadeOut(withDuration: 2.0))
            //sign!.readSign = false
            print("sign: \(sign!.readSign)")
        }
    }
    
    func wearCostume(node: PlayerNode) {
        player!.characterType = 3
        player?.removeAllActions()
        player?.texture = SKTexture(imageNamed: "warrior_costume_idle_00")
        player?.run(SKAction.setTexture(SKTexture(imageNamed: "warrior_costume_idle_00")))
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.costume?.costumeTransfer = false
            
        }
    }
    
    /**
     gives the tile map physics
     */
    func giveTileMapPhysics(map: SKTileMapNode) {
        let tileMap = map
        
        //size
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
                        
                        //gives tiles a physics body
                        tileNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (tileTexture.size().width), height: (tileTexture.size().height)))
                        
                        //physics body settings
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
                        
                        //edge cases
                        if (isEdgeTile == 1) {
                            tileNode.physicsBody?.restitution = 0.0
                            tileNode.physicsBody?.contactTestBitMask = ColliderType.PLAYER
                        }
                        
                        //assures player doesnt fall through floor
                        tileNode.physicsBody?.categoryBitMask = ColliderType.GROUND
                        tileMap.addChild(tileNode)
                    }
                }
            }
        }
    }
    
    /**
     displays the game over screen
     */
    func displayGameOverScene() {
        
        //marks the game as over
        gameOver = true
        
        UserDefaultsManager.shared.defaults.removeObject(forKey: "levelCandyAmount")
        
        if let scene = GKScene(fileNamed: "GameOverScene") {
            if let sceneNode = scene.rootNode as! GameOverScene? {
          
                sceneNode.size = self.view!.bounds.size
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                //present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 0.5))

                    view.ignoresSiblingOrder = true

                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.showsPhysics = true
                }
                
            }
            
        }
    }
    
    /**
     focuses the camera on the player
     */
    func centerOnNode(node: SKNode) {
        self.camera!.run(SKAction.move(to: CGPoint(x: node.position.x, y: node.position.y), duration: 0.5))
    }
    
    /**
     updates the frame
     */
    override func didFinishUpdate() {
        centerOnNode(node: player!)
    }
    
    /**
     updates the frames
     */
    override func update(_ currentTime: TimeInterval) {
        //called before each frame is rendered
        
        //initalize _lastUpdateTime if it hasn't been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        //updates the candy labe;
        if let candyLabel = camera?.childNode(withName: "CandyLabel") as? SKLabelNode {
            updateCandyLabel(label: candyLabel)
        }
        
        if let signText = self.childNode(withName: "costumeCandySignText") as? SKSpriteNode {
            openSign(node: signText)
        }
        
        if player!.dead == true || nextLevelSign?.levelComplete == true {
            displayGameOverScene()
        }
        
        //calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        //update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        if costume?.costumeTransfer == true {
            wearCostume(node: player!)
        }
        
        //updates the packground system
        parallaxSystem?.update(deltaTime: currentTime)
        
        self.lastUpdateTime = currentTime
    }
}
