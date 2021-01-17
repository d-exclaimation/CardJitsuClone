//
//  BankWindowCard.swift
//  Battle Cards
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import SwiftUI

struct BankWindowCard: View {
    
    @Binding var showBank: Bool
    var playerBank: [BattleSystem<Color, String>.Card]
    var cornerRadius: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            bankDisplay(item: playerBank)
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9)
                .offset(x: geometry.size.width * 0.05, y: showBank ? .zero : geometry.size.height * 1.2)
        }
        .navigationBarBackButtonHidden(showBank)
    }
    
    // Reusable Bank UI
    private func bankDisplay(item: [BattleSystem<Color, String>.Card]) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(Color.white)
                .opacity(0.8)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke()
                .shadow(color: Color.black.opacity(0.5), radius: 1, x: 3, y: 4)
            
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
