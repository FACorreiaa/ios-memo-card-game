//
//  EmojiMemoryGame.swift
//  Memorise
//
//  Created by Fernando Correia on 23.10.23.
//

import SwiftUI

//func makeCardContent(index: Int) -> String {
//    return "😶"
//}



class EmojiMemoryGame: ObservableObject {
    static let emojis = ["😐", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "123", "1234", "12345", "123456", "1234567", "12345678", "123456789", "1234567890", "0", "00", "000", "000", "Duck", "Duckling", "Duckler"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { index in  EmojiMemoryGame.emojis[index] }
    }
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}


