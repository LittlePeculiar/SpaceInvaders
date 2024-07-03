//
//  ContentView.swift
//  SpaceInvaders
//
//  Created by Gina Mullins on 6/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            GameView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
