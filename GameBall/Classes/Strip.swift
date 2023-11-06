//
//  Strip.swift
//  GameBall
//
//  Created by Kirill Khomytsevych on 04.11.2023.
//

import SpriteKit
import GameplayKit

final class Strip: SKSpriteNode, GameElementsAbles {

    // MARK: - Intrface mothods
    static func populate(at point: CGPoint?) -> SKShapeNode {
        // Создайте прямоугольник
        let whiteRoundedRect = SKShapeNode()
        let rectPath = CGMutablePath()
        let cornerRadius: CGFloat = 2.0
        let rect = CGRect(x: .zero, y: .zero, width: 100.0, height: 10.0)

        rectPath.addRoundedRect(in: rect, cornerWidth: cornerRadius, cornerHeight: cornerRadius)

        whiteRoundedRect.path = rectPath
        whiteRoundedRect.fillColor = .white
        whiteRoundedRect.zPosition = 5.0
        whiteRoundedRect.strokeColor = .clear
        whiteRoundedRect.physicsBody?.isDynamic = false
        whiteRoundedRect.position = point ?? randomPoint()
        whiteRoundedRect.name = Constants.NameElements.strip
        whiteRoundedRect.run(SKAction.rotate(toAngle: .zero,
                                             duration: .zero))
        whiteRoundedRect.run(move(from: whiteRoundedRect.position))

        let physicsBody = SKPhysicsBody(polygonFrom: whiteRoundedRect.path!)
        // Настройте физическое тело
        physicsBody.isDynamic = false
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = BitMaskCategory.strips
        physicsBody.collisionBitMask = BitMaskCategory.ball
        physicsBody.contactTestBitMask = BitMaskCategory.ball

        // Установите физическое тело для whiteRoundedRect
        whiteRoundedRect.physicsBody = physicsBody

        return whiteRoundedRect
    }
}

// MARK: - Private methods
private extension Strip {

    static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: UIScreen.main.bounds.size.height + 10.0)
        let moveDistance = UIScreen.main.bounds.size.height - point.y + 10.0
        let movementSpeed: CGFloat = 125.0
        let duration: TimeInterval = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: duration)
    }
}
