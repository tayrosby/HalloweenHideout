//
//  ChargeComponent.swift
//  HalloweenHideout
//
//

import SpriteKit
import GameplayKit

protocol ChargeComponentDelegate: class {
    func chargeComponentDidLoseCharge(chargeComponenet: ChargeComponent)
}

class ChargeComponent: GKComponent {
    var charge: Double
    let maximumCharge: Double
    
    var percentageCharge: Double {
        if maximumCharge == 0 {
            return 0.0
        }
            
        return charge / maximumCharge
    }
    
    var hasCharge: Bool {
        return (charge > 0.0)
    }
    
    var isFullyCharged: Bool {
        return charge == maximumCharge
    }
    
    let chargeBar: ChargeBar?
    
    weak var delegate: ChargeComponentDelegate?
    
    init(charge: Double, maximumCharge: Double, displayChargeBar: Bool = false) {
        self.charge = charge
        self.maximumCharge = maximumCharge
        
        if displayChargeBar {
            chargeBar = ChargeBar()
        } else {
            chargeBar = nil
        }
        
        super.init()
        
        chargeBar?.level = percentageCharge
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loseCharge(chargeToLose: Double) {
        var newCharge = charge - chargeToLose
        
        newCharge = min(maximumCharge, newCharge)
        newCharge = max(0.0, newCharge)
        
        if newCharge < charge {
            charge = newCharge
            chargeBar?.level = percentageCharge
            delegate?.chargeComponentDidLoseCharge(chargeComponenet: self)
        }
    }
    
    func addCharge(chargeToAdd: Double) {
        var newCharge = charge + chargeToAdd
        
        newCharge = min(maximumCharge, newCharge)
        newCharge = max(0.0, newCharge)
        
        if newCharge > charge {
            charge = newCharge
            chargeBar?.level = percentageCharge
        }
    }
    
}





