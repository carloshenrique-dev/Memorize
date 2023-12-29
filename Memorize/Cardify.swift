//
//  Cardify.swift
//  Memorize
//
//  Created by Carlos Henrique on 28/12/23.
//

import SwiftUI

struct Cardify: ViewModifier {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(style: StrokeStyle(lineWidth: edgeLineWidth))
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius).fill(.orange)
                .opacity(isFaceUp ? 0: 1)
        }
        .rotation3DEffect(
            Angle.degrees(rotation),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 2.5
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
