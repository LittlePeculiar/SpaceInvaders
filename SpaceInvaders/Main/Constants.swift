//
//  Constants.swift
//  SpaceInvaders
//
//  Created by Gina Mullins on 6/28/24.
//

import UIKit

enum InvaderDirection: CGFloat {
    case right = 1.0
    case left = -1.0
}

struct Constants {
    static var screenSize = UIScreen.main.bounds
    
    struct Start {
        static var startingPosition = CGPoint(
            x: screenSize.width / 2,
            y: screenSize.height - 100
        )
    }
    
}
