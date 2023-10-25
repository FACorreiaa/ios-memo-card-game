//
//  Cardify.swift
//  Memorise
//
//  Created by Fernando Correia on 25.10.23.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            }
            else {
                shape.fill()
            }
            content.opacity(isFaceUp ? 1 : 0)
        }
        
    }
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10;
        static let lineWidth: CGFloat = 3
        
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
