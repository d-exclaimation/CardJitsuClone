//
//  Buttonify.swift
//  Battle Cards
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import Foundation
import SwiftUI

struct Buttonify: ViewModifier {
    var color: Color
    var length: CGFloat
    var opacity: Double = 0.9
    var cornerRadius: CGFloat
    var fontColor: Color = .white

    
    init(color: Color, size: Size, opacity: Double = 0.9, curve: CGFloat = 20, fontColor: Color) {
        self.color = color
        switch size {
            case .small:
                length = 10
            case .large:
                length = 40
            case .medium:
                length = 25
            case .custom(let custom):
                length = custom
            case .none:
                length = 0
        }
        self.opacity = opacity
        self.cornerRadius = curve
        self.fontColor = fontColor
    }
    
    func body(content: Content) -> some View {
        content.foregroundColor(fontColor).padding().padding(.horizontal, length).background(color.opacity(opacity)).cornerRadius(cornerRadius)
    }
    
}

enum Size {
    case small
    case large
    case medium
    case none
    case custom(length: CGFloat)
}

extension View {
    func buttonify(color: Color, size: Size, opacity: Double = 0.9, curve: CGFloat = 20, fontColor: Color = .white) -> some View {
        self.modifier(Buttonify(color: color, size: size, opacity: opacity, curve: curve, fontColor: fontColor))
    }
}
