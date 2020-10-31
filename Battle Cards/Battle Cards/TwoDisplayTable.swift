//
//  TwoDisplayTable.swift
//  Battle Cards
//
//  Created by Vincent on 10/29/20.
//

import SwiftUI

struct TwoDisplayTable: View {
    
    var data: EmojiCardBattleGame
    var isWon: Bool
    var opacity: Double
    var radius: CGFloat
    var pads: CGFloat
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                tableSet1
                Spacer()
                tableIndicator()
                Spacer()
                tableSet2
            }
            .padding()
            .background(Color.black.opacity(opacity))
            .cornerRadius(radius)
            .padding(.horizontal, pads)
            Spacer()
        }
    }
    
    private var tableSet1: some View {
        CardView(element: data.currentTable[0].element, power: data.currentTable[0].power, color: data.currentTable[0].color, isFaceUp: data.currentTable[0].isFaceUp)
    }
    
    private var tableSet2: some View {
        CardView(element: data.currentTable[1].element, power: data.currentTable[1].power, color: data.currentTable[1].color, isFaceUp: data.currentTable[1].isFaceUp)
    }

    private func tableIndicator() -> some View {
        if isWon {
            return IndicatorAlert(systemName: "checkmark.circle.fill", color: .green, scale: .medium)
        } else {
            return IndicatorAlert(systemName: "xmark.circle.fill", color: .red, scale: .medium)
        }
    }
    
    
}
