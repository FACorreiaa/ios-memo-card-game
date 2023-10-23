//
//  ContentView.swift
//  Memorise
//
//  Created by Fernando Correia on 20.10.23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var emojiCount = 20
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) {card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit).onTapGesture{
                            viewModel.choose(card)
                        }
                    }
                }.foregroundColor(.red)
            }
//            Spacer()
//            HStack{
//                add
//                Spacer(minLength: 20)
//                remove
//            }.font(.largeTitle).padding(.horizontal)
        }.padding(.horizontal)
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
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
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
    }
}




















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game).preferredColorScheme(.dark)
    }
}
