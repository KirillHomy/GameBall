//
//  GameStripsAbles.swift
//  GameBall
//
//  Created by Kirill Khomytsevych on 04.11.2023.
//

import SpriteKit
import GameplayKit

protocol GameElementsAbles {
    associatedtype ElementType

    static func populate(at point: CGPoint?) -> ElementType
    static func randomPoint() -> CGPoint
}

// MARK: - extension GameElementsAbles
extension GameElementsAbles {

    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution()
        let xPoint = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width - 100.0)))
        let yPoint = CGFloat(distribution.nextInt())
        return CGPoint(x: xPoint, y: yPoint)
    }
}
