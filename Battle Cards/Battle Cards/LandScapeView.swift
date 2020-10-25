//
//  LandScapeView.swift
//  Battle Cards
//
//  Created by Vincent on 10/22/20.
//

import SwiftUI

struct LandScapeView: View {
    var gameBackground: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(gameBackground)
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
        }
    }
}

