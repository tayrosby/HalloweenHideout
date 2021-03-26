//
//  IntelligenceComponents.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 3/16/21.
//

import SpriteKit
import GameplayKit

class IntelligenceComponent: GKComponent {
    
    let stateMachine: GKStateMachine
    
    let initialStateClass: AnyClass
    
    init(states: [GKState]) {
        stateMachine = GKStateMachine(states: states)
        let firstState = states.first!
        initialStateClass = type(of: firstState)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        stateMachine.update(deltaTime: seconds)
    }
    
    func enterInitialState(){
        stateMachine.enter(initialStateClass)
    }
}
