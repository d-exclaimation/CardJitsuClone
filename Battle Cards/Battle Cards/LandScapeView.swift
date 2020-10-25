//
//  LandScapeView.swift
//  Battle Cards
//
//  Created by Vincent on 10/22/20.
//

import SwiftUI

struct LandScapeView: View {
    var theme: BattleTheme
    var range: Range<Int> {
        0..<theme.colorPicker.count
    }
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(theme.themeBackground))
                .ignoresSafeArea(.all)
            Rectangle()
                .foregroundColor(.white)
                .opacity(0.2)
                .rotationEffect(Angle.degrees(9))
                .ignoresSafeArea(.all)
            Rectangle()
                .foregroundColor(.white)
                .opacity(0.1)
                .rotationEffect(Angle.degrees(-69))
                .ignoresSafeArea(.all)
            GeometryReader { geometry in
                VStack {
                    Image("preview")
                        .scaleEffect(1.2)
                        .padding()
                        .background(Color(theme.themeBackground).opacity(0.6))
                        .cornerRadius(20)
                    ForEach(0..<elements.count) { indices in
                        HStack {
                            ForEach(0..<colors.count) { index in
                                CardView(
                                    element: elements[indices],
                                    power: Int.random(in: 0...20),
                                    color: colors[index],
                                    isFaceUp: true
                                )
                                .padding()
                            }
                            
                        }
                    }
                }
                .offset(x: geometry.size.width/4 - 40, y: geometry.size.height/40)
            }
            
        }
    }
    
    var elements: [String] {
        theme.elementPicker
    }
    
    var colors: [Color] {
        theme.colorPicker.map { Color($0) }
    }
}

struct LandScapeView_Previews: PreviewProvider {
    static var previews: some View {
        LandScapeView(theme: BattleTheme.art)
    }
}
