//
//  GameView.swift
//  SpaceInvaders
//
//  Created by Gina Mullins on 6/28/24.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()
    
    @State private var timer: Timer? = nil
    @State private var shootTimer: Timer? = nil
    @State private var showGameOver: Bool = false
    @State private var canShoot: Bool = true
    
    var body: some View {
        ZStack() {
            Color.black
                .ignoresSafeArea()
            
            if !viewModel.isGameOver {
                
                Text("Score: \(viewModel.score)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .position(x: 100, y: 50)
                
                Text("Lives: \(viewModel.playerLives)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .position(x: Constants.screenSize.width - 100, y: 50)
                
                
                ForEach(viewModel.invaders, id: \.id) { invader in
                    Image(invader.imageName)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .position(invader.position)
                }
                
                Image("rocket")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .position(viewModel.playerPostion)
                    .gesture(
                        DragGesture()
                            .onChanged({ drag in
                                viewModel.movePlayer(to: drag.location)
                            })
                    )
                
                ForEach(viewModel.bullets, id: \.id) { bullet in
                    Rectangle()
                        .frame(width: 5, height: 20)
                        .position(bullet.position)
                        .foregroundColor(.red)
                    
                }
                
                
            }
            
        }
        .onTapGesture {
            if canShoot {
                viewModel.shootBullet()
                canShoot = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.canShoot = true
                }
            }
        }
        .onAppear {
            start()
        }
        .onChange(of: viewModel.isGameOver) { isGameOver in
            if isGameOver {
                timer?.invalidate()
                shootTimer?.invalidate()
                showGameOver = true
            }
        }
        .sheet(isPresented: $showGameOver) {
            GameOverView(
                score: viewModel.score,
                isWinner: viewModel.playerLives > 0,
                restartAction: start)
        }
        .frame(
            width: Constants.screenSize.width,
            height: Constants.screenSize.height
        )
    }
    
    func start() {
        viewModel.startGame()
        
        // player timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            viewModel.updateGame()
        })
        
        // alien shooting timer
        shootTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { _ in
            viewModel.invaderShootBullet()
        })
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
