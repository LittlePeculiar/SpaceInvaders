//
//  AnimatableFontModifier.swift
//  SpaceInvaders
//
//  Created by Gina Mullins on 6/28/24.
//

import SwiftUI

// A modifier that animates a font through various sizes.
struct AnimatableFontModifier: ViewModifier, Animatable {
    var size: CGFloat
    var animatableSize: CGFloat {
        get { size }
        set { size = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
    }
}
