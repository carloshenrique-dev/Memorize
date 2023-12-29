//
//  Cardify.swift
//  Memorize
//
//  Created by Carlos Henrique on 28/12/23.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(style: StrokeStyle(lineWidth: edgeLineWidth))
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill(.orange)
            }
        }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 2.5
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
