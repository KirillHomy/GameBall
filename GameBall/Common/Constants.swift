//
//  Constants.swift
//  GameBall
//
//  Created by Kirill Khomytsevych on 06.11.2023.
//

import SpriteKit

enum Constants {

    enum General {
        static let url = "https://2llctw8ia5.execute-api.us-west-1.amazonaws.com/prod"
        static let gravity: CGFloat = -3.0
    }

    enum UserDefaults {
        static let links = "links"
    }

    enum Button {
        static let start = "startButton"
        static let restart = "restartButton"
    }

    enum Notification {
        static let result = "GameOverResultNotification"
    }

    enum Images {
        static let background = "background"
        static let start = "start"
        static let restart = "restart"
        static let close = "xmark.circle.fill"
    }

    enum NameElements {
        static let strip = "strip"
        static let ball = "ball"
        static let island = "island"
    }

    enum Font {
        static let helvetica = "Helvetica"
    }
}
