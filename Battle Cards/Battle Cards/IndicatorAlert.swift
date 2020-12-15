//
//  IndicatorAlert.swift
//  Battle Cards
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import SwiftUI

struct IndicatorAlert: View {
    
    let systemName: String
    let color: Color
    let scale: Image.Scale
    
    var body: some View {
        ZStack {
            Image(systemName: "circle.fill")
                .imageScale(scale)
                .foregroundColor(.white)
            Image(systemName: systemName)
                .imageScale(scale)
                .foregroundColor(color)
        }
    }
}

struct IndicatorAlert_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorAlert(systemName: "xmark.circle.fill", color: .red, scale: .medium)
    }
}
