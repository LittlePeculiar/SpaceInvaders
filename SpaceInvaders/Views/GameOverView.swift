//
//  GameOverView.swift
//  SpaceInvaders
//
//  Created by Gina Mullins on 6/28/24.
//

import SwiftUI

struct GameOverView: View {
    @State var score: Int
    @State var isWinner: Bool
    @State var fontSize: CGFloat = 12
    var restartAction: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Spacer()
                
                Text(isWinner ? "You Win\n🏆" : "You Died\n👻")
                    .animatableFont(size: fontSize)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                    .padding()
                    .onAppear {
                        withAnimation(.spring(
                            response: 0.5,
                            dampingFraction: 0.5,
                            blendDuration: 1).delay(1.0)
                        ) {
                            fontSize = 72
                        }
                    }
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                
                Button {
                    dismiss()
                    restartAction()
                } label: {
                    Text("Restart")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(
            score: 0,
            isWinner: true,
            restartAction: {}
        )
    }
}
