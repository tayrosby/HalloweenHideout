//
//  TouchController.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 1/30/21.
//

import SpriteKit

class TouchController : SKSpriteNode {
    
    var alphaUnpressed:CGFloat = 0.5
    var alphaPressed:CGFloat = 0.9
    
    var pressedButtons = [SKSpriteNode]()
    
    let buttonDirLeft = SKSpriteNode(imageNamed: "Button - PS Directional Arrow Left")
    let buttonDirRight = SKSpriteNode(imageNamed: "Button - PS Directional Arrow Right")
    
    let buttonA = SKSpriteNode(imageNamed: "button_xbox_digital_a_1")
    let buttonB = SKSpriteNode(imageNamed: "button_xbox_digital_b_1")
    
    var inputDelegate : ControlInputDelagate?
    
    init(frame: CGRect) {
        
        super.init(texture: nil, color: UIColor.clear, size: frame.size)
        
        
        setupControls(size: frame.size)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addButton(button: SKSpriteNode, position: CGPoint, name: String, scale: CGFloat) {
        
        button.position = position
        button.setScale(scale)
        button.name = name
        button.zPosition = 20
        button.alpha = alphaUnpressed
        self.addChild(button)
        
    }
    
    func setupControls(size :CGSize) {
        addButton(button: buttonDirLeft, position: CGPoint(x: -(size.width / 3) - 45, y: -size.height / 4), name: "left", scale: 0.17)
        addButton(button: buttonDirRight, position: CGPoint(x: -(size.width / 3) + 45, y: -size.height / 4), name: "right", scale: 0.17)
        addButton(button: buttonA, position: CGPoint(x: (size.width / 3) + 45, y: -size.height / 4), name: "A", scale: 0.15)
        addButton(button: buttonB, position: CGPoint(x: (size.width / 3) - 45, y: -size.height / 4), name: "B", scale: 0.15)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: parent!)
            
            for button in [buttonDirLeft, buttonDirRight, buttonA, buttonB] {
                if button.contains(location) && pressedButtons.firstIndex(of: button) == nil {
                    pressedButtons.append(button)
                    if ((inputDelegate) != nil) {
                        inputDelegate?.follow(command: button.name!)
                    }
                }
                if pressedButtons.firstIndex(of: button) == nil {
                    button.alpha = alphaUnpressed
                } else {
                    button.alpha = alphaPressed
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
            let location = t.location(in: parent!)
            let previousLocation = t.previousLocation(in: parent!)
            
            for button in[buttonDirLeft, buttonDirRight, buttonA, buttonB] {
                if button.contains(previousLocation) && !button.contains(location) {
                    let index = pressedButtons.firstIndex(of: button)
                    if index != nil {
                        pressedButtons.remove(at: index!)
                        
                        if ((inputDelegate) != nil) {
                            inputDelegate?.follow(command: "cancel \(String(describing:button.name!))")
                        }
                    }
                } else if
                    !button.contains(previousLocation) && button.contains(location) && pressedButtons.firstIndex(of: button) == nil {
                        pressedButtons.append(button)
                    if ((inputDelegate) != nil) {
                        inputDelegate?.follow(command: button.name!)
                    }
                }
                if pressedButtons.firstIndex(of: button) == nil {
                    button.alpha = alphaUnpressed
                } else {
                    button.alpha = alphaPressed
                }            }
            
        }
    }
    
    func touchUp(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        for t in touches! {
            
            let location = t.location(in: parent!)
            let previousLocation = t.previousLocation(in: parent!)
            
            for button in[buttonDirLeft, buttonDirRight, buttonA, buttonB] {
                if button.contains(location) {
                    let index = pressedButtons.firstIndex(of: button)
                    if index != nil {
                        pressedButtons.remove(at: index!)
                        if ((inputDelegate) != nil){
                            inputDelegate?.follow(command: "stop \(String(describing: button.name!))")
                        }
                    }
                }
                else if (button.contains(previousLocation)) {
                    let index = pressedButtons.firstIndex(of: button)
                    if index != nil {
                        pressedButtons.remove(at: index!)
                        if ((inputDelegate) != nil){
                            inputDelegate?.follow(command: "stop \(String(describing: button.name!))")
                        }
                    }
                }
                if pressedButtons.firstIndex(of: button) == nil {
                    button.alpha = alphaUnpressed
                }
                else {
                    button.alpha = alphaPressed
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchUp(touches: touches, withEvent: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchUp(touches: touches, withEvent: event)
    }
    
}
