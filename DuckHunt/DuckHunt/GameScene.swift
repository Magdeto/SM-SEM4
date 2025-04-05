//
//  GameScene.swift
//  DuckHunt
//
//  Created by Magda Tsekova on 22/03/2025.
//
import SpriteKit
import GameplayKit
import CoreNFC

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ducks: [SKSpriteNode] = []
    var bullets: [SKSpriteNode] = []
    let maxBullets = 3
    let maxDucks = 3
    var bulletCount = 0
    
    let bulletCategory: UInt32 = 0x1 << 0
    let duckCategory: UInt32 = 0x1 << 1
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self // Enables physics-based collision detection
        physicsWorld.gravity = CGVector(dx: 0, dy: 0) // Set gravity to zero (not space-like)
        
        // Set up the background
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        background.size = size
        addChild(background)
        
        spawnInitialDucks()
    }
    
    func spawnInitialDucks() {
        for _ in 0..<maxDucks {
            spawnDuck()
        }
    }
    
    func spawnDuck() {
        let duck = SKSpriteNode(imageNamed: "duck")
        duck.setScale(0.8)
        let randomX = CGFloat.random(in: 0...size.width)
        duck.position = CGPoint(x: randomX, y: size.height / 2)
        
        // Physics body setup
        duck.physicsBody = SKPhysicsBody(rectangleOf: duck.size)
        duck.physicsBody?.affectedByGravity = false
        duck.physicsBody?.categoryBitMask = duckCategory
        duck.physicsBody?.collisionBitMask = 0 // Ducks don’t collide with each other
        duck.physicsBody?.contactTestBitMask = bulletCategory
        duck.physicsBody?.velocity = CGVector(dx: CGFloat.random(in: -200...200), dy: CGFloat.random(in: 100...300))
        duck.physicsBody?.linearDamping = 0 // Remove damping to maintain speed
        
        
        addChild(duck)
        ducks.append(duck)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard bulletCount < maxBullets, let touch = touches.first else {
            print("out of ammo")
            return
        }
        let location = touch.location(in: self)
        shootBullet(at: location)
    }
    
    func shootBullet(at position: CGPoint) {
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.setScale(0.2)
        bullet.position = CGPoint(x: size.width / 2, y: 50)
        
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width / 2)
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.categoryBitMask = bulletCategory
        bullet.physicsBody?.contactTestBitMask = duckCategory
        bullet.physicsBody?.collisionBitMask = 0
        bullet.physicsBody?.linearDamping = 0
        
        
        // Calculate direction
        let dx = position.x - bullet.position.x
        let dy = position.y - bullet.position.y
        let distance = sqrt(dx * dx + dy * dy)
        let direction = CGVector(dx: dx/distance, dy: dy/distance)
        
        bullet.physicsBody?.velocity = CGVector(dx: direction.dx * 1000, dy: direction.dy * 1000)
        
        addChild(bullet)
        bullets.append(bullet)
        bulletCount += 1
        
        print("Bullet shot! Count: \(bulletCount)") // Debug print
        
        
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        // Check if the collision is between bullet and duck
        if (firstBody.categoryBitMask == bulletCategory && secondBody.categoryBitMask == duckCategory) ||
            (firstBody.categoryBitMask == duckCategory && secondBody.categoryBitMask == bulletCategory) {
            
            let bullet = firstBody.categoryBitMask == bulletCategory ? firstBody.node : secondBody.node
            let duck = firstBody.categoryBitMask == duckCategory ? firstBody.node : secondBody.node
            
            if let bulletNode = bullet as? SKSpriteNode, let duckNode = duck as? SKSpriteNode {
                duckHit(duck: duckNode, bullet: bulletNode)
            }
        }
    }
    
    func duckHit(duck: SKSpriteNode, bullet: SKSpriteNode) {
        print("Duck hit!") // debug print
        
        // Remove nodes
        duck.removeFromParent()
        bullet.removeFromParent()
        
        // Update arrays
        ducks.removeAll { $0 == duck }
        
        // Spawn new duck if needed
        if ducks.count < maxDucks {
            spawnDuck()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Handle duck bouncing
        for duck in ducks {
            if duck.position.x <= 0 || duck.position.x >= size.width {
                duck.physicsBody?.velocity.dx *= -1
            }
            if duck.position.y <= 0 || duck.position.y >= size.height {
                duck.physicsBody?.velocity.dy *= -1
            }
        }
        
        // Handle bullet cleanup
        var bulletsToRemove: [SKSpriteNode] = []
        for bullet in bullets {
            if bullet.position.y > size.height || bullet.position.y < 0 ||
                bullet.position.x < 0 || bullet.position.x > size.width {
                bulletsToRemove.append(bullet)
            }
        }
        
        for bullet in bulletsToRemove {
            bullet.removeFromParent()
            if let index = bullets.firstIndex(of: bullet) {
                bullets.remove(at: index)
                bulletCount -= 1
            }
        }
    }
    
}
