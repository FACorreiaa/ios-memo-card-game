//
//  MemoryGame.swift
//  Memorise
//
//  Created by Fernando Correia on 23.10.23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfFaceCardUp: Int? {
        get {
             cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly
        }
        set {
            cards.indices.forEach({cards[$0].isFaceUp = ($0 == newValue)})
        }
    }
    
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {
            $0.id == card.id
        }), !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            
            if let potentialIndexMatchIndex  = indexOfFaceCardUp {
                if cards[chosenIndex].content == cards[potentialIndexMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialIndexMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfFaceCardUp = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        //add number x2 cards to cards array
        for index in 0..<numberOfPairsOfCards{
            let content = createCardContent(index)
            cards.append(Card(content: content, id:  index * 2))
            cards.append(Card(content: content, id:  index * 2 + 1))
            cards.append(Card(content: content, id:  index * 2 + 2))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int

    }
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
