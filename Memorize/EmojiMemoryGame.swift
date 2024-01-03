//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Carlos Henrique on 26/12/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    @Published var showAlert: Bool = false
    @Published var victoryAnimation: Bool = false
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["😀", "😍", "🥳", "🚀"] //"🎉", "👍", "🌈", "🎈", "🤩", "🔥"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
        
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
        victory()
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    func victory() {
        if model.victory {
            showAlert = true
        }
    }
}
