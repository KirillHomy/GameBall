//
//  Background.swift
//  GameBall
//
//  Created by Kirill Khomytsevych on 04.11.2023.
//

import SpriteKit

final class Background: SKSpriteNode {

    // MARK: - Intrface mothods
    static func populateBackground(at point: CGPoint) -> Background {
        let background = Background(imageNamed: Constants.Images.background)
        background.position = point
        background.zPosition = .zero

        return background
    }
}
