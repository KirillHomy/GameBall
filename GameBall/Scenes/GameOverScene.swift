//
//  GameOverScene.swift
//  GameBall
//
//  Created by Kirill Khomytsevych on 05.11.2023.
//

import SpriteKit
import UIKit
import WebKit

class GameOverScene: SKScene {

    // MARK: - Private constants
    private let webView = WKWebView()
    private let closeButton = UIButton(type: .system)
    private let resultLabel = SKLabelNode(fontNamed: Constants.Font.helvetica)

    // MARK: - didMove
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        configurate()
        setupWebView(view)
        setupCloseButton(view)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleResultGameNotification),
                                               name: NSNotification.Name(Constants.Notification.result),
                                               object: nil)
    }

    // MARK: - touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }

        let node = self.atPoint(location)
        if node.name == Constants.Button.restart {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
    }
}

// MARK: - Private methods
private extension GameOverScene {

    func configurate() {
        setupBackgroundColor()
        setupResultLabel()
        setupRestartButton()
    }

    func setupBackgroundColor() {
        self.backgroundColor = SKColor(red: 49.0 / 255.0,
                                       green: 5.0 / 255.0,
                                       blue: 24.0 / 255.0,
                                       alpha: 1.0)
    }

    func setupResultLabel() {
        resultLabel.fontSize = 50.0
        resultLabel.position = CGPoint(x: self.frame.midX,
                                       y: self.frame.midY + 150.0)
        self.addChild(resultLabel)
    }

    func setupRestartButton() {
        let restartButton = SKSpriteNode(imageNamed: Constants.Images.restart)
        restartButton.setScale(0.3)
        restartButton.position = CGPoint(x: self.frame.midX,
                                         y: self.frame.midY)
        restartButton.name = Constants.Button.restart
        self.addChild(restartButton)
    }

    func setupCloseButton(_ view: SKView) {
        closeButton.frame = CGRect(x: UIScreen.main.bounds.width - 60.0,
                                   y: 20.0,
                                   width: 40.0,
                                   height: 40.0)
        let closeImage = UIImage(systemName: Constants.Images.close)
        closeButton.setImage(closeImage, for: .normal)
        closeButton.tintColor = .gray
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        view.addSubview(closeButton)
    }

    func setupWebView(_ view: SKView) {
        webView.frame = CGRect(x: .zero,
                               y: .zero,
                               width: view.frame.size.width,
                               height: view.frame.size.height)
        view.addSubview(webView)
    }
}

// MARK: - Objc-c methods
@objc extension GameOverScene {

    func handleResultGameNotification(notification: Notification) {
        if let isGameOver = notification.object as? Bool {
            resultLabel.text = isGameOver ? "Winner" : "Loser"
            if let data = UserDefaults.standard.data(forKey: Constants.UserDefaults.links) {
                let decoder = JSONDecoder()
                if let savedLinks = try? decoder.decode(LinksModel.self, from: data) {
                    if let url = URL(string: isGameOver ? "\(savedLinks.winner)"
                                                        : "\(savedLinks.loser)") {
                        let request = URLRequest(url: url)
                        webView.load(request)
                    }
                }
            }
        }
    }

    func didTapCloseButton() {
        webView.isHidden = true
        closeButton.isHidden = true
        webView.removeFromSuperview()
        closeButton.removeFromSuperview()
    }
}
