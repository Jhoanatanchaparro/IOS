//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jhonatan David Chaparro Alvarez on 10/06/25.
//

import SwiftUI


class EmojiMemoryGame {
    
    static let emojis = ["⚽️", "🏀", "🏉", "🏐", "⚾️", "🏈", ]
    
    static func createMemoryGame() -> MemoryGame<String>{
        MemoryGame<String> (numberOfPairsOfBalones: 4) { pairIndex in emojis [pairIndex]
        }

    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var balones: Array<MemoryGame<String>.Balones>{
        return model.balones
    }
    
}
