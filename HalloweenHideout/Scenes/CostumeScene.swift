    //
    //  CostumeScene.swift
    //  HalloweenHideout
    //
    //
    
    import SpriteKit
    import GameplayKit
    
    class CostumeScene: SKScene{
        var gameScene: GameScene?
        lazy var shop : Shop = { return Shop(costumeScene: gameScene!) }()
        var buttonBuy: ButtonController!
        var buttonBack: ButtonController!
        var buyLabel : SKLabelNode?
        var costumeLabel : SKLabelNode?
        var costumeDescription : SKLabelNode?
        var priceLabel : SKLabelNode?
        var costume : SKSpriteNode?
        var nodeName = ""
        
        var player : PlayerNode?
        var costumeNode : Costume?
        var costumeNodes = [CostumeNode]()
        
        lazy var selectedNode : CostumeNode? = {
            return self.costumeNodes.first!
        }()
        
        //list of costumes
        var allCostumes: [Costume] = [ Costume(name: "Hero Knight", texture: SKTexture(imageNamed: "hero_costume_idle00"), price: 0, description: "evil wizard"), Costume(name: "Martial Hero", texture: SKTexture(imageNamed: "martial_costume_idle0"), price: 0, description: "eviler wizard"), Costume(name: "Fanatsy Warrior", texture: SKTexture(imageNamed: "warrior_costume_idle_00"), price: 0, description: "fantasy warrior")]
        
        init(nodeName: String) {
            self.nodeName = nodeName
            super.init()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override func didMove(to view: SKView) {
            //Setup your scene here
            
            //Set UI connections
            buttonBuy = self.childNode(withName: "buttonBuy") as? ButtonController
            buttonBack = self.childNode(withName: "buttonBack") as? ButtonController
            
            //button handlers
            buttonBack.selectedHandler = {
                self.backToShop()
            }
            
            //buys the costume
            buttonBuy.selectedHandler = {
                self.buyCostume(self.costumeNode!.price)
            }
            
            if let theCostumeLabel = self.childNode(withName: "costumeLabel") {
                costumeLabel = theCostumeLabel as? SKLabelNode
            }
            
            if let thePriceLabel = self.childNode(withName: "priceLabel") {
                priceLabel = thePriceLabel as? SKLabelNode
            }
            
            if let theBuyLabel = self.childNode(withName: "buyLabel") {
                buyLabel = theBuyLabel as? SKLabelNode
            }
            
            if let theCostumeDescription = self.childNode(withName: "costumeDescription") {
                costumeDescription = theCostumeDescription as? SKLabelNode
            }
            
            if let theCostume = self.childNode(withName: "costume") {
                costume = theCostume as? SKSpriteNode
            }
            
            setCostumeDetails(costumeName: nodeName)
            setUpNodes()
            
            
        }
        
        /**
         sets up the nodes for the scene
         */
        func setUpNodes() {
            //set up the costume nodes
            setUpCostumeNodes: do {
                //add costume to costume nodes
                for costume in allCostumes {
                    costumeNodes.append(CostumeNode(costume: costume, player: player))
                }
            }
            
        }
        
        /**
         updates price labes
         */
        private func setPriceText() {
            /**
             sets 
             */
            func playerCanAfford() {
                priceLabel?.text = "$\(costumeNode?.price ?? 0)"
                priceLabel?.fontColor = .white
            }
            
            func playerCantAfford() {
                priceLabel?.text = "$\(costumeNode?.price ?? 0)"
                priceLabel?.fontColor = .red
            }
            
            func playerOwns() {
                priceLabel?.text = ""
                priceLabel?.fontColor = .white
            }
            
            //calls above method based on costume and candy amount
            if ((player?.hasCostume(self.costumeNode!)) != nil)         { playerOwns() }
            else if UserDefaultsManager.shared.getPlayerTotalCandyAmount() < self.costumeNode?.price ?? 0  { playerCantAfford() }
            else if UserDefaultsManager.shared.getPlayerTotalCandyAmount() >= self.costumeNode?.price ?? 0 { playerCanAfford()  }
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
         sets the costume details based on which one was selected
         */
        func setCostumeDetails(costumeName: String) {
            
            switch costumeName{
            case "costume1":
                costumeLabel?.text = "Hero Knight"
                costumeDescription?.text = "costume 1"
                costumeNode?.price = 500
                setPriceText()
                costume?.texture = SKTexture(imageNamed: "hero_costume_idle00")
                costume?.size = CGSize(width: 280, height: 280)
            case "costume2":
                costumeLabel?.text = "Martial Hero"
                costumeDescription?.text = "costume 2"
                costumeNode?.price = 1000
                setPriceText()
                costume?.texture = SKTexture(imageNamed: "martial_costume_idle0")
                costume?.size = CGSize(width: 280, height: 280)
            case "costume3":
                costumeLabel?.text = "Fantasy Warrior"
                costumeDescription?.text = "costume 3"
                costumeNode?.price = 5
                setPriceText()
                costume?.texture = SKTexture(imageNamed: "warrior_costume_idle_00")
                costume?.size = CGSize(width: 280, height: 280)
            default:
                costumeLabel?.text = "N/A"
                costumeDescription?.text = "N/A"
                priceLabel?.text = "N/A"
                
            }
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
            if UserDefaultsManager.shared.getPlayerTotalCandyAmount() < costumeNode.costume!.price {
                buyLabel?.text = "Can't Afford"
            } else {
                buyLabel?.text = "Buy"
            }
        }
        
        /**
         buys the costume
         */
        func buyCostume(_ amount: CGFloat){
            //sets price labels and color
            priceLabel?.text = "Own"
            priceLabel?.color = UIColor.white
            //removes button to prevent buying again
            buttonBuy.removeFromParent()
            player?.loseCandy(amount)
        }
        
        /**
         navigates to the store scene
         */
        func backToShop() {
            if let scene = GKScene(fileNamed: "ShopScene") {
                if let sceneNode = scene.rootNode as! ShopScene? {
                    
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
    }
