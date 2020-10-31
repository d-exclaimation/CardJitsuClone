//
//  BankWindowCard.swift
//  Battle Cards
//
//  Created by Vincent on 10/29/20.
//

import SwiftUI

struct BankWindowCard: View {
    
    @Binding var showBank: Bool
    var playerBank: [BattleSystem<Color, String>.Card]
    var cornerRadius: CGFloat
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            bankDisplay(item: playerBank, color: color)
                .frame(width: geometry.size.width*0.9, height: geometry.size.height*0.9)
                .offset(x: geometry.size.width*0.05, y: showBank ? geometry.size.height*0.05 : geometry.size.height * 1.2)
        }
    }
    
    // Reusable Bank UI
    private func bankDisplay(item: [BattleSystem<Color, String>.Card], color: Color) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(color)
                .opacity(0.8)
            
            Grid(item) { card in
                CardView(element: card.element, power: card.power, color: card.color, isFaceUp: card.isFaceUp)
            }
        }
    }
}
//
//struct BankWindowCard_Previews: PreviewProvider {
//    static var previews: some View {
//        BankWindowCard()
//    }
//}
