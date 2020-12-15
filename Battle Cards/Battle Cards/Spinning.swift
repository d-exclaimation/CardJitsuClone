//
//  Spinning.swift
//  ArtMaker
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import Foundation
import SwiftUI

struct Spinning: ViewModifier {
    
    @State var isVisible: Bool = false
    var speed: Double
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: isVisible ? 360 : 0))
            .animation(Animation.linear(duration: speed).repeatForever(autoreverses: false))
            .onAppear {
                isVisible = true
            }
    }
}

extension View {
    func spinning(speed: Double = 1.5) -> some View {
        self.modifier(Spinning(speed: speed))
    }
}
