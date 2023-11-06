//
//  Island.swift
//  GameBall
//
//  Created by Kirill Khomytsevych on 06.11.2023.
//

import SpriteKit

final class Island: SKShapeNode, GameElementsAbles {

    static func populate(at point: CGPoint?) -> Island {
        let island = Island(circleOfRadius: 5.0)
        island.fillColor = .green
        island.strokeColor = .clear
        island.position = point ?? randomPoint()
        island.zPosition = 3.0
        island.physicsBody = SKPhysicsBody(circleOfRadius: 5.0)
        island.physicsBody?.isDynamic = true
        island.name = Constants.NameElements.island
        island.physicsBody?.isDynamic = false
        island.physicsBody?.affectedByGravity = false
        island.physicsBody?.categoryBitMask = BitMaskCategory.island
        island.physicsBody?.collisionBitMask = BitMaskCategory.ball
        island.physicsBody?.contactTestBitMask = BitMaskCategory.ball

        return island as! Self
    }
}
