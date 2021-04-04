//
//  UserDefaultsManager.swift
//  HalloweenHideout
//
//

import SpriteKit

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    //creates the UD database
    let defaults = UserDefaults(suiteName: "com.tay.HalloweenHideout.saved.data")!
    
    /**
     saves the total amount of candy the user has collected
     */
    public func savePlayerTotalCandyAmount(candyAmount: CGFloat) {
        defaults.setValue(candyAmount, forKey: "totalCandyAmount")
    }
    
    /**
     gets the total amount of candy the player has collected
     */
    public func getPlayerTotalCandyAmount() -> CGFloat {
        
        //if the value exists return it, otherwise return 0
        if let value = defaults.value(forKey: "totalCandyAmount") as? CGFloat {
            return value
        }
        return 0.0
    }
    
    /**
     saves the amount of candy the user has collected in a level
     */
    public func savePlayerLevelCandyAmount(candyAmount: CGFloat) {
        defaults.setValue(candyAmount, forKey: "levelCandyAmount")
    }
    
    /**
     gets the amount of candy the user has collected in a level
     */
    public func getPlayerLevelCandyAmount() -> CGFloat {
        //if the value exists return it, otherwise return 0
        if let value = defaults.value(forKey: "levelCandyAmount") as? CGFloat {
            
            return value
        }
        return 0.0
    }
}
