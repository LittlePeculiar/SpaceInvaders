//
//  View+Ext.swift
//  SpaceInvaders
//
//  Created by Gina Mullins on 6/28/24.
//

import SwiftUI

extension View {
    func animatableFont(size: CGFloat) -> some View {
        self.modifier(AnimatableFontModifier(size: size))
    }
}
