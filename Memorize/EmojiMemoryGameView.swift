//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Carlos Henrique on 26/12/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(style: StrokeStyle())
                    Text(card.content)
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: cornerRadius).fill(.orange)
                    }
                }
            }
            .font(.system(size: fontSize(for: geometry.size)))
        }
    }
    
    // MARK: - Drawing Consts
    
    let cornerRadius: CGFloat = 10.0
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
