//
//  ScreenShake.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 2/5/21.
//

import SpriteKit

extension SKAction {
    class func shake(initialPosition: CGPoint, duration: Float, amplitudeX: Int = 12, amplitudeY: Int = 3) -> SKAction {
        let startingX = initialPosition.x
        let startingY = initialPosition.y
        let numberOfShakes = duration / 0.015
        var actionsArray:[SKAction] = []
        
        for _ in 1...Int(numberOfShakes){
            let newXPos = startingX + CGFloat(arc4random_uniform(UInt32(amplitudeX))) - CGFloat(amplitudeX / 2)
            let newYPos = startingY + CGFloat(arc4random_uniform(UInt32(amplitudeY))) - CGFloat(amplitudeY / 2)
            actionsArray.append(SKAction.move(to: CGPoint(x: newXPos, y: newYPos), duration: 0.015))
        }
        actionsArray.append(SKAction.move(to: initialPosition, duration: 0.015))
        return SKAction.sequence(actionsArray)
    }
}
