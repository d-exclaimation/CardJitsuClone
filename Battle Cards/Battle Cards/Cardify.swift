//
//  Cardify.swift
//  Memorize
//
//  Created by Vincent on 9/23/20.
//  Copyright © 2020 Vincent. All rights reserved.
//

import Foundation
import SwiftUI

struct Cardify: AnimatableModifier {
    private var rotation: Double
    var animatableData: Double {
        // Adjust automatically with the rotation value
        get { return rotation }
        set { rotation = newValue }
    }
    
    // Initializers using faceUp or faceDown
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    // Automatic compute faceup when rotation has flip yet
    private var isFaceUp: Bool {
        rotation < 90
    }
    
    func body(content: Content) -> some View {
        ZStack {
            // Faceup card
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(.white)

                content
            }.opacity(isFaceUp ? 1 : 0) // Transparent when face down, and opaque when face up
            // Face Down
            RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(.gray)
                .opacity(isFaceUp ? 0 : 1) // Opposite of the previous
            
        }.rotation3DEffect(Angle.degrees(rotation), axis: flipAxis) // Rotate the cards anchored to the Y line, so it is possible to animate a flipping card

        
    }
    
    // MARK: - Constants
    private let cornerRadius: CGFloat = 10.0
    private let lineWidth: CGFloat = 3
    private let flipAxis: (CGFloat, CGFloat, CGFloat) = (0,1,0)
}

// Make function easier to call
extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
