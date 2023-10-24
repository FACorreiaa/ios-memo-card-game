//
//  MemoriseApp.swift
//  Memorise
//
//  Created by Fernando Correia on 20.10.23.
//

import SwiftUI

@main
struct MemoriseApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryCardView(game: game)
        }
    }
}
