//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Carlos Henrique on 26/12/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
