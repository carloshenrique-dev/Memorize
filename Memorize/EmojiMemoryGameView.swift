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
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75), { viewModel.choose(card: card) })
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(.orange)
            Button {
                withAnimation(.easeInOut, { viewModel.resetGame() })
            } label: {
                Text("New Game")
            }

        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                                .onAppear {
                                    startBonusTimeAnimation()
                                }
                        } else {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                        }
                    }
                    .padding(10).opacity(0.4)
                    Text(card.content)
                        .font(.system(size: fontSize(for: geometry.size)))
                        .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? .linear(duration:1).repeatForever(autoreverses: false) : .default, value: card.isMatched)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
            }
        }
    }
    
    // MARK: - Drawing Consts
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}


#Preview {
    let game = EmojiMemoryGame()
    game.choose(card: game.cards[7])
    return EmojiMemoryGameView(viewModel: game)
}
