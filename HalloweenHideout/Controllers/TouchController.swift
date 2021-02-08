//
//  TouchController.swift
//  HalloweenHideout
//
//

import SpriteKit

class TouchController : SKSpriteNode {
    
    //pressed and unpressed values
    var alphaUnpressed:CGFloat = 0.5
    var alphaPressed:CGFloat = 0.9
    
    var pressedButtons = [SKSpriteNode]()
    
    //directional buttions
    let buttonDirLeft = SKSpriteNode(imageNamed: "Button - PS Directional Arrow Left")
    let buttonDirRight = SKSpriteNode(imageNamed: "Button - PS Directional Arrow Right")
    
    //action butions
    let buttonA = SKSpriteNode(imageNamed: "button_xbox_digital_a_1")
    let buttonB = SKSpriteNode(imageNamed: "button_xbox_digital_b_1")
    
    //input detection
    var inputDelegate : ControlInputDelagate?
    
    init(frame: CGRect) {
        
        super.init(texture: nil, color: UIColor.clear, size: frame.size)
        
        
        setupControls(size: frame.size)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     adds the buttons to the game scene
     */
    func addButton(button: SKSpriteNode, position: CGPoint, name: String, scale: CGFloat) {
        
        //button position on screne
        button.position = position
        button.setScale(scale)
        button.name = name
        
        //button layer position
        button.zPosition = 20
        
        //sets button to unpressed
        button.alpha = alphaUnpressed
        
        //adds button to game scene
        self.addChild(button)
        
    }
    
    /**
     sets up the cpntrol buttons on the screen
     */
    func setupControls(size :CGSize) {
        //calls the add button method
        addButton(button: buttonDirLeft, position: CGPoint(x: -(size.width / 3) - 45, y: -size.height / 4), name: "left", scale: 0.17)
        addButton(button: buttonDirRight, position: CGPoint(x: -(size.width / 3) + 45, y: -size.height / 4), name: "right", scale: 0.17)
        addButton(button: buttonA, position: CGPoint(x: (size.width / 3) + 45, y: -size.height / 4), name: "A", scale: 0.15)
        addButton(button: buttonB, position: CGPoint(x: (size.width / 3) - 45, y: -size.height / 4), name: "B", scale: 0.15)
    }
    
    /**
     check if user has touched a button
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: parent!)
            
            //if button is pressed, give it pressed value
            for button in [buttonDirLeft, buttonDirRight, buttonA, buttonB] {
                if button.contains(location) && pressedButtons.firstIndex(of: button) == nil {
                    pressedButtons.append(button)
                    if ((inputDelegate) != nil) {
                        //tells the button which animation to call
                        inputDelegate?.follow(command: button.name!)
                    }
                }
                //if the button isn't pressed set it to unpressed
                if pressedButtons.firstIndex(of: button) == nil {
                    button.alpha = alphaUnpressed
                } else {
                    button.alpha = alphaPressed
                }
            }
        }
    }
    
    /**
     checks for the change in the touch input
     */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
            let location = t.location(in: parent!)
            let previousLocation = t.previousLocation(in: parent!)
            
            //if button is pressed, give it pressed value
            for button in[buttonDirLeft, buttonDirRight, buttonA, buttonB] {
                if button.contains(previousLocation) && !button.contains(location) {
                    let index = pressedButtons.firstIndex(of: button)
                    if index != nil {
                        pressedButtons.remove(at: index!)
                        
                        //tells the button which animation to call and add cancel key word
                        if ((inputDelegate) != nil) {
                            inputDelegate?.follow(command: "cancel \(String(describing:button.name!))")
                        }
                    }
                }//if the button hasn't been previously pressed give it pressed value
                else if !button.contains(previousLocation) && button.contains(location) && pressedButtons.firstIndex(of: button) == nil {
                        pressedButtons.append(button)
                    //tells the button which animation to call
                    if ((inputDelegate) != nil) {
                        inputDelegate?.follow(command: button.name!)
                    }
                }
                
                //if the button isn't pressed set it to unpressed
                if pressedButtons.firstIndex(of: button) == nil {
                    button.alpha = alphaUnpressed
                } else {
                    button.alpha = alphaPressed
                }
                    
                }
            
        }
    }
    
    /**
     checks if the input has finished
     */
    func touchUp(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        for t in touches! {
            
            let location = t.location(in: parent!)
            let previousLocation = t.previousLocation(in: parent!)
            
            for button in[buttonDirLeft, buttonDirRight, buttonA, buttonB] {
                if button.contains(location) {
                    let index = pressedButtons.firstIndex(of: button)
                    if index != nil {
                        //tells the button which animation to call and add stop keyword
                        pressedButtons.remove(at: index!)
                        if ((inputDelegate) != nil){
                            inputDelegate?.follow(command: "stop \(String(describing: button.name!))")
                        }
                    }
                }
                else if (button.contains(previousLocation)) {
                    let index = pressedButtons.firstIndex(of: button)
                    if index != nil {
                        //tells the button which animation to call and add stop keyword
                        pressedButtons.remove(at: index!)
                        if ((inputDelegate) != nil){
                            inputDelegate?.follow(command: "stop \(String(describing: button.name!))")
                        }
                    }
                }
                //if the button isn't pressed set it to unpressed
                if pressedButtons.firstIndex(of: button) == nil {
                    button.alpha = alphaUnpressed
                }
                else {
                    button.alpha = alphaPressed
                }
            }
        }
    }
    
    /**
     checks if the user has stopped touching the button
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchUp(touches: touches, withEvent: event)
    }
    
    /**
     checked if the user has cancelled a touch action
     */
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchUp(touches: touches, withEvent: event)
    }
    
}
