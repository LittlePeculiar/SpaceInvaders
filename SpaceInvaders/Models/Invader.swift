//
//  Invader.swift
//  SpaceInvaders
//
//  Created by Gina Mullins on 6/28/24.
//

import Foundation

class Invader: GameItem {
    var imageName: String
    
    init(position: CGPoint, imageName: String = "alien") {
        self.imageName = imageName
        
        super.init(position: position)
    }
}
