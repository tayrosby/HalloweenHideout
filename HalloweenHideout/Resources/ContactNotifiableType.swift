//
//  ContactNotifiableType.swift
//  HalloweenHideout
//
//  Created by Taylor Austin on 3/16/21.
//

import GameplayKit

protocol ContactNotifiableType {
    func contactWithEntityDidBegan(_ entity: GKEntity)
    func contactWithEntityDidEnd(_ entity: GKEntity)
}
