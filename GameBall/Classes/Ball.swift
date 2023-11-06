//
//  Ball.swift
//  GameBall
//
//  Created by Kirill Khomytsevych on 04.11.2023.
//

import SpriteKit
import CoreMotion

final class Ball: SKShapeNode {

    // MARK: - Private constnats
    private let motionManager = CMMotionManager()
    private let screenSize = CGSize(width: UIScreen.main.bounds.width,
                                    height: UIScreen.main.bounds.height)

    // MARK: - Private variable
    private var xAcceleration: CGFloat = .zero
}

// MARK: - Inerface methods
extension Ball {

    static func populate(at point: CGPoint) -> Ball {
        let ball = Ball(circleOfRadius: 20.0)
        ball.fillColor = .red
        ball.strokeColor = .clear
        ball.position = point
        ball.zPosition = 5.0
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 20.0)
        ball.physicsBody?.isDynamic = true
        ball.name = Constants.NameElements.ball
        ball.physicsBody?.categoryBitMask = BitMaskCategory.ball
        ball.physicsBody?.contactTestBitMask = BitMaskCategory.island | BitMaskCategory.strips
        ball.physicsBody?.collisionBitMask = BitMaskCategory.island | BitMaskCategory.strips

        return ball
    }

    func checkXPosition() {
        self.position.x += xAcceleration * 50.0

        let halfBallWidth = 25.0

        // Бокавые грани
        if self.position.x < halfBallWidth {
            self.position.x = halfBallWidth
        } else if self.position.x > screenSize.width - halfBallWidth {
            self.position.x = screenSize.width - halfBallWidth
        }

        // Нижняя грань
        if self.position.y < halfBallWidth {
            self.position.y = halfBallWidth
        }
    }

    func performFly() {
        // Acceleration
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x * 0.7) + self.xAcceleration * 0.3
            }
        }
    }
}
