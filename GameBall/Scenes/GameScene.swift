//
//  GameScene.swift
//  GameBall
//
//  Created by Kirill Khomytsevych on 02.11.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    // MARK: - Private variables
    private var ball: Ball!
    private var startTime: TimeInterval = 0.0
    private var lifesBall = 3

    // MARK: - Private constants
    private let screen = UIScreen.main.bounds
    private let timerLabel = SKLabelNode(fontNamed: Constants.Font.helvetica)
    private let lifeLabel = SKLabelNode(fontNamed: Constants.Font.helvetica)

    // MARK: - didMove
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: Constants.General.gravity)

        configurate()
    }

    // MARK: - didSimulatePhysics
    override func didSimulatePhysics() {
        super.didSimulatePhysics()

        ball.checkXPosition()

        // Удаляем элементы которые вышли за рамку видимости
        enumerateChildNodes(withName: Constants.NameElements.strip) { node, stop in
            if node.position.y > self.screen.height {
                node.removeFromParent()
            }
        }
    }

    // MARK: - update
    override func update(_ currentTime: TimeInterval) {
        updateGame()
    }
}

// MARK: - Private methods
private extension GameScene {

    func configurate() {
        createBackground()
        createBall()
        createIsland()
        createTimerLabel()
        createLiveLabel()
        startTimer()
        spawnStrips()
        ball.performFly()
    }

    func createBackground() {
        let screenCenterPoint = CGPoint(x: self.size.width / 2.0, y: self.size.height / 2.0)
        let background = Background.populateBackground(at: screenCenterPoint)
        self.addChild(background)
    }

    func createBall() {
        ball = Ball.populate(at: CGPoint(x: screen.size.width / 2.0, y: screen.size.height - 100.0))
        self.addChild(ball)
    }

    func createIsland() {
        for _ in 1...5 {
            let xPoint = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width - 100.0)))
            let yPoint = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.height - 200.0)))
            let island = Island.populate(at: CGPoint(x: xPoint, y: yPoint))
            addChild(island)
        }
    }

    func createTimerLabel() {
        timerLabel.zPosition = 3.0
        timerLabel.fontSize = 20.0
        timerLabel.position = CGPoint(x: 50.0, y: screen.height - 50.0)
        self.addChild(timerLabel)
    }

    func createLiveLabel() {
        lifeLabel.zPosition = 3.0
        lifeLabel.fontSize = 20.0
        lifeLabel.position = CGPoint(x: screen.width - 50.0, y: screen.height - 50.0)
        self.addChild(lifeLabel)
    }

    func spawnStrips() {
        let spawnStripWait = SKAction.wait(forDuration: 2.0)
        let spawnStripAction = SKAction.run {
            let strip = Strip.populate(at: nil)
            self.addChild(strip)
        }
        let spawnStripsSequence = SKAction.sequence([spawnStripWait, spawnStripAction])
        let spawnStripForever = SKAction.repeatForever(spawnStripsSequence)
        run(spawnStripForever)
    }

    func updateGame() {
        // Обновление времени
        let currentTime = Date().timeIntervalSinceReferenceDate
        let elapsedTime = currentTime - startTime

        if elapsedTime > 30.0 {
            goGameOverScene()
            NotificationCenter.default.post(name: NSNotification.Name(Constants.Notification.result),
                                            object: true)
        } else if ball.position.y > screen.height + 20.0 || lifesBall == 0 {
            goGameOverScene()
            NotificationCenter.default.post(name: NSNotification.Name(Constants.Notification.result),
                                            object: false)
        }
        timerLabel.text = "Time: \(Int(elapsedTime))"
        lifeLabel.text = "Life: \(Int(lifesBall))"
    }

    func goGameOverScene() {
        let transition = SKTransition.crossFade(withDuration: 1.0)
        let gameOverScene = GameOverScene(size: self.size)
        gameOverScene.scaleMode = .aspectFill
        self.scene?.view?.presentScene(gameOverScene, transition: transition)
    }

    func startTimer() {
        startTime = Date().timeIntervalSinceReferenceDate
    }
}

// MARK: - SKPhysicsContactDelegate
extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == Constants.NameElements.ball {
            if contact.bodyB.node?.parent != nil {
                contact.bodyB.node?.removeFromParent()
                lifesBall -= 1
            }
        }
    }
}
