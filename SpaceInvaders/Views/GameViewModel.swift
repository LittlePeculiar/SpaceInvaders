//
//  GameViewModel.swift
//  SpaceInvaders
//
//  Created by Gina Mullins on 6/28/24.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var bullets = [Bullet]()
    @Published var invaders = [Invader]()
    @Published var playerLives: Int = 3
    @Published var score: Int = 0
    @Published var playerPostion: CGPoint = Constants.Start.startingPosition
    @Published var invaderDirection: InvaderDirection = .right
    @Published var isGameOver: Bool = false
    
    let playerSpeed: CGFloat = 10
    let invaderSpeed: CGFloat = 5
    
    func startGame() {
        bullets.removeAll()
        invaders.removeAll()
        
        playerLives = 3
        score = 0
        invaderDirection = .right
        isGameOver = false
        
        createInvaders()
    }
    
    func updateGame() {
        // called from Timer
        updateBullets()
        updateInvaders()
        checkCollision()
        checkGameOver()
    }
    
    func createInvaders() {
        var items = [Invader]()
        let rows = 5
        let columns = 5
        let spacing: CGFloat = 60
        
        for row in 0..<rows {
            for column in 0..<columns {
                let x = spacing * CGFloat(column) + spacing / 2
                let y = spacing * CGFloat(row) + 100
                
                let position = CGPoint(x: x, y: y)
                let item = Invader(position: position)
                items.append(item)
            }
        }
        self.invaders = items
    }
    
    func movePlayer(to location: CGPoint) {
        let width = Constants.screenSize.width
        let newX = min(max(location.x, 0), width)
        playerPostion.x = newX
    }
    
    func updateInvaders() {
        for i in 0..<invaders.count {
            invaders[i].position.x += invaderSpeed * invaderDirection.rawValue
        }
        
        let width = Constants.screenSize.width
        if invaders.contains(where: {
            $0.position.x > width - 20 || $0.position.x < 20
        }) {
            switchDirection()
            for i in 0..<invaders.count {
                invaders[i].position.y += 10
            }
        }
    }
    
    func shootBullet() {
        let start = CGPoint(
            x: playerPostion.x,
            y: playerPostion.y - 30
        )
        let end = CGPoint(
            x: playerPostion.x,
            y: 0
        )
        
        addBullet(start: start, end: end, isPlayerBullet: true)
    }
    
    func invaderShootBullet() {
        // from shoot timer
        guard !invaders.isEmpty else {
            return
        }
        
        let randomIndex = Int.random(in: 0..<invaders.count)
        let position = invaders[randomIndex].position
        let start = CGPoint(x: position.x, y: position.y + 20)
        let end = playerPostion
        
        addBullet(start: start, end: end, isPlayerBullet: false)
    }
    
    func addBullet(start: CGPoint, end: CGPoint, isPlayerBullet: Bool) {
        let angle = atan2(end.y - start.y, end.x - start.x)
        let velocityX = cos(angle) * 10
        let velocityY = sin(angle) * 10
        let velocity = CGVector(
            dx: velocityX,
            dy: velocityY
        )
        let bullet = Bullet(
            position: start,
            velocity: velocity,
            isPlayerBullet: isPlayerBullet
        )
        
        bullets.append(bullet)
    }
    
    func updateBullets() {
        for i in 0..<bullets.count {
            bullets[i].position.x += bullets[i].velocity.dx
            bullets[i].position.y += bullets[i].velocity.dy
        }
        
        let height = Constants.screenSize.height
        bullets = bullets.filter({
            $0.position.y > 0 && $0.position.y < height
        })
    }
    
    func checkCollision() {
        
        for bullet in bullets {
            for invader in invaders {
                if abs(bullet.position.x - invader.position.x) < 20 &&
                    abs(bullet.position.y - invader.position.y) < 20 &&
                    bullet.isPlayerBullet {
                    if let index = bullets.firstIndex(where: {
                        $0.id == bullet.id
                    }) {
                        bullets.remove(at: index)
                    }
                    if let index = invaders.firstIndex(where: {
                        $0.id == invader.id
                    }) {
                        invaders.remove(at: index)
                        score += 1
                    }
                    break
                }
            }
        }
        
        for bullet in bullets {
            if abs(bullet.position.x - playerPostion.x) < 20 &&
                abs(bullet.position.y - playerPostion.y) < 20 &&
                !bullet.isPlayerBullet {
                if let index = bullets.firstIndex(where: {
                    $0.id == bullet.id
                }) {
                    bullets.remove(at: index)
                }
                playerLives -= 1
                
                if playerLives <= 0 {
                    isGameOver = true
                }
                break
            }
        }
        
    }
    
    func checkGameOver() {
        if invaders.isEmpty {
            isGameOver = true
        }
        
    }
    
    func switchDirection() {
        invaderDirection = invaderDirection == .right ? .left : .right
    }
    

}
