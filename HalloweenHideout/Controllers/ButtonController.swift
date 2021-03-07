//
//  ButtonController.swift
//  HalloweenHideout
//
//

import SpriteKit

enum ButtonControllerState {
    case ButtonControllerStateActive, ButtonControllerStateSelected, ButtonControllerStateHidden
}

class ButtonController: SKSpriteNode {
    
    /* Setup a dummy action closure */
    var selectedHandler: () -> Void = { print("No button action set") }
    
    /* Button state management */
    var state: ButtonControllerState = .ButtonControllerStateActive {
        didSet {
            switch state {
            case .ButtonControllerStateActive:
                /* Enable touch */
                self.isUserInteractionEnabled = true
                
                /* Visible */
                self.alpha = 1
                break
            case .ButtonControllerStateSelected:
                /* Semi transparent */
                self.alpha = 0.7
                break
            case .ButtonControllerStateHidden:
                /* Disable touch */
                self.isUserInteractionEnabled = false
                
                /* Hide */
                self.alpha = 0
                break
            }
        }
    }
    
    /* Support for NSKeyedArchiver (loading objects from SK Scene Editor */
    required init?(coder aDecoder: NSCoder) {
        
        /* Call parent initializer e.g. SKSpriteNode */
        super.init(coder: aDecoder)
        
        /* Enable touch on button node */
        self.isUserInteractionEnabled = true
    }
    
    // MARK: - Touch handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .ButtonControllerStateSelected
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedHandler()
        state = .ButtonControllerStateActive
    }
    
}
