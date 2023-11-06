//
//  MenuScene.swift
//  GameBall
//
//  Created by Kirill Khomytsevych on 04.11.2023.
//

import SpriteKit

class MenuScene: SKScene {

    // MARK: - didMove
    override func didMove(to view: SKView) {

        configurate()
    }

    // MARK: - touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }

        let node = self.atPoint(location)
        if node.name == Constants.Button.start {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
    }
}

// MARK: - Private methods
private extension MenuScene {

    func configurate() {
        setupBackgroundColor()
        setupStartButton()
    }

    func setupBackgroundColor() {
        self.backgroundColor = SKColor(red: 49.0 / 255.0,
                                       green: 5.0 / 255.0,
                                       blue: 24.0 / 255.0,
                                       alpha: 1.0)
    }

    func setupStartButton() {
        let startButton = SKSpriteNode(imageNamed: Constants.Images.start)
        startButton.setScale(0.3)
        startButton.position = CGPoint(x: self.frame.midX,
                                       y: self.frame.midY)
        startButton.name = Constants.Button.start
        self.addChild(startButton)
    }
}
