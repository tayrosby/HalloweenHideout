//
//  ContactNotifiableType.swift
//  HalloweenHideout
//
//

import GameplayKit

protocol ContactNotifiableType {
    func contactWithEntityDidBegan(_ entity: GKEntity)
    func contactWithEntityDidEnd(_ entity: GKEntity)
}
