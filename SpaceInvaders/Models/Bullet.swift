//
//  Bullet.swift
//  SpaceInvaders
//
//  Created by Gina Mullins on 6/28/24.
//

import Foundation

class Bullet: GameItem {
    var velocity: CGVector
    var isPlayerBullet: Bool
    
    init(position: CGPoint, velocity: CGVector, isPlayerBullet: Bool) {
        self.velocity = velocity
        self.isPlayerBullet = isPlayerBullet
        
        super.init(position: position)
    }
}
