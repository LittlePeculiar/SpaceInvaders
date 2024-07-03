//
//  GameItem.swift
//  SpaceInvaders
//
//  Created by Gina Mullins on 6/28/24.
//

import Foundation

class GameItem: Identifiable {
    var id: String = UUID().uuidString
    var position: CGPoint
    
    init(position: CGPoint) {
        self.position = position
    }
}

