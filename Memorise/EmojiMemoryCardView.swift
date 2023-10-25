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
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 20))
                    .padding(5)
                    .opacity(0.5)
                    Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.easeInOut(duration: 2).repeatForever())
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
                }
            .cardify(isFaceUp: card.isFaceUp)
            })
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
        
    }
}




















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryCardView(game: game).preferredColorScheme(.dark)
    }
}
