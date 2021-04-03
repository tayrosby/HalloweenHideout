//
//  UserDefaultsManager.swift
//  HalloweenHideout
//
//

import SpriteKit

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    let defaults = UserDefaults(suiteName: "com.tay.HalloweenHideout.saved.data")!
    
    public func savePlayerTotalCandyAmount(candyAmount: CGFloat) {
        defaults.setValue(candyAmount, forKey: "totalCandyAmount")
    }
    
    public func getPlayerTotalCandyAmount() -> CGFloat {
        
        if let value = defaults.value(forKey: "totalCandyAmount") as? CGFloat {
            return value
        }
        return 0.0
    }
    
    public func savePlayerLevelCandyAmount(candyAmount: CGFloat) {
        defaults.setValue(candyAmount, forKey: "levelCandyAmount")
    }
    
    public func getPlayerLevelCandyAmount() -> CGFloat {
        
        if let value = defaults.value(forKey: "levelCandyAmount") as? CGFloat {
            
            return value
        }
        return 0.0
    }
}
