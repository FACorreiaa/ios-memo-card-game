//
//  MemoryGame.swift
//  Memorise
//
//  Created by Fernando Correia on 23.10.23.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    private var indexOnlyOfTheOneFaceUpCard: Int? = nil
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {
            $0.id == card.id
        }), cards[chosenIndex].isFaceUp,
            cards[chosenIndex].isMatched {
            
            if let potentialIndexMatchIndex  = indexOnlyOfTheOneFaceUpCard {
                if cards[chosenIndex].content == cards[potentialIndexMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialIndexMatchIndex].isMatched = true
                }
                indexOnlyOfTheOneFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOnlyOfTheOneFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("chosen card = \(cards)")
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        //add number x2 cards to cards array
        for index in 0..<numberOfPairsOfCards{
            let content = createCardContent(index)
            cards.append(Card(content: content, id:  index * 2))
            cards.append(Card(content: content, id:  index * 2 + 1))
            cards.append(Card(content: content, id:  index * 2 + 2))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int

    }
}
