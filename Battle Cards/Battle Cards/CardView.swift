//
//  CardVie.swift
//  Battle Cards
//
//  Created by Vincent on 9/24/20.
//

import SwiftUI

struct CardView: View {
    var element: String
    var power: Int
    var color: Color
    var isFaceUp: Bool
    
    var body: some View {
        GeometryReader { geometry in
            cardBody(for: geometry.size)
        }.frame(width: 80, height: 120)
    }
    
    // MARK: - Drawing constant
    private let textFontSize: CGFloat = 70
    private let cardPadding: CGFloat = 5
    
    // MARK: - Card Body
    private func cardBody(for size: CGSize) -> some View {
        VStack{
            Text(element)
            Text("\(power)")
                .font(.system(size: scaledSize(given: size) - 20))
                .padding(cardPadding)
        }
        .font(.system(size: scaledSize(given: size)))
        .background(Color.white)
        .cornerRadius(cardPadding)
        .cardify(isFaceUp: isFaceUp)
        .foregroundColor(color)
    }
    
    private func scaledSize(given size: CGSize) -> CGFloat { min(size.width, size.height) * 0.5 }
    
    
}

struct CardVie_Previews: PreviewProvider {
    static var previews: some View {
        CardView(element: "☘️", power: 10, color: Color.blue, isFaceUp: true)
    }
}
