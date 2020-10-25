//
//  ElementTriangle.swift
//  Battle Cards
//
//  Created by Vincent on 10/24/20.
//

import SwiftUI

struct ElementTriangle: View {
    
    var elements: [String]
    @Environment(\.colorScheme) var scheme
    
    private let opacityBubble: Double = 0.85
    @State private var bubble: Color = .white
    private let curve: CGFloat = 100
    
    var body: some View {
        ZStack {
            Circle().stroke().frame(width: curve, height: curve)
            VStack {
                Text("\(elements[0])")
                    .padding()
                    .background(bubble.opacity(opacityBubble))
                    .cornerRadius(curve)
                HStack(spacing: 20) {
                    Text("\(elements[2])")
                        .padding()
                        .background(bubble.opacity(opacityBubble))
                        .cornerRadius(curve)
                    Text("\(elements[1])")
                        .padding()
                        .background(bubble.opacity(opacityBubble))
                        .cornerRadius(curve)
                }
            }
            .font(.system(size: 40))
        }
        .onAppear {
            bubble = scheme == ColorScheme.dark ? .white : .black
        }
    }
}

struct ElementTriangle_Previews: PreviewProvider {
    static var previews: some View {
        ElementTriangle(elements: ["1", "2", "3"])
    }
}
