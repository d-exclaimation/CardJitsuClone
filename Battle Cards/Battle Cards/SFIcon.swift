//
//  SFButton.swift
//  Battle Cards
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import SwiftUI

struct SFIcon: View {
    let sfName: String
    let bgColor: Color
    let label: String
    let action: () -> Void
    
    
    init(_ method: @escaping () -> Void) {
        sfName = "circle.grid.cross.fill"
        bgColor = Color.black
        label = ""
        action = method
    }
    
    init(systemName: String, with background: Color, named title: String, _ method: @escaping () -> Void) {
        sfName = systemName
        bgColor = background
        label = title
        action = method
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Image(systemName: sfName)
                    .foregroundColor(.white)
                    .imageScale(.large)
                    .padding(20)
                Text(label)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding(10)
            .background(bgColor.opacity(0.7))
            .cornerRadius(20)
        }
    }
}
