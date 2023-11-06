//
//  BitMaskCategory.swift
//  GameBall
//
//  Created by Kirill Khomytsevych on 04.11.2023.
//

import Foundation

struct BitMaskCategory {

    static let ball: UInt32          = 0x1 << 0          // 000000...00001
    static let island: UInt32        = 0x1 << 1          // 000000...00010
    static let strips: UInt32        = 0x1 << 2          // 000000...00100

}
