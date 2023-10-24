//
//  ContentView.swift
//  Memorise
//
//  Created by Fernando Correia on 20.10.23.
//

import SwiftUI

struct EmojiMemoryCardView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: {card in
            cardView(for: card)
        })
        .foregroundColor(.red)
        .padding(.horizontal)
                
//            Spacer()
//            HStack{
//                add
//                Spacer(minLength: 20)
//                remove
//            }.font(.largeTitle).padding(.horizontal)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .onTapGesture{ game.choose(card) }
        }
    }
    
//    var add: some View {
//        Button {
//            if(emojiCount < viewModel.cards.capacity) {
//                emojiCount += 1
//            }
//        } label: {
//            Image(systemName: "plus.circle")
//        }.font(.largeTitle)
//    }
//    var remove: some View {
//        Button(action: {
//            if(emojiCount > 1) {
//                emojiCount -= 1
//            }
//        }, label: {
//            Image(systemName: "minus.circle")
//
//        }).font(.largeTitle)
//    }
}



struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader(content: {geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 20))
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    shape.fill()
                }
            }
            //        }.onTapGesture{
            //            card.isFaceUp = !card.isFaceUp
            //        }
            
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10;
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        
    }
}




















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryCardView(game: game).preferredColorScheme(.dark)
    }
}
