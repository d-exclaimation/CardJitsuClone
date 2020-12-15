//
//  InfoPanel.swift
//  Battle Cards
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import SwiftUI

struct InfoPanel: View {
    
    @Binding var showInfos: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Information").bold()) {
                    Text("This game is copy of the game Card Jitsu from Club Penguin, Made into Mobile App")
                }
                
                Section(header: Text("How to play").bold()) {
                    Text("To win you must collect cards in your bank with the sequence of:")
                    Text("- 3 Cards, different Elements and Colors\n- 3 Cards, same Elements, different Colors")
                }
                
                Section(header: Text("Instruction").bold(), footer: Text("Element first, power later")) {
                    Text("To collect cards and put in the bank, You have to win with the card. Winning the cards depends on two factors:\n - Element Advantage\n - Higher Power Level")
                }
                
                Section(header: Text("Element Advantages").bold(), footer: Text("Win against next element clockwise")) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(BattleTheme.all) { theme in
                                ElementTriangle(elements: theme.elementPicker)
                                    .padding()
                            }
                        }
                    }

                }
            }
            .navigationBarTitle(Text("Game information"))
            .navigationBarItems(trailing: done)
        }
    }
    
    var done: some View {
        Button {
            showInfos.toggle()
        } label: {
            Text("Done")
                .foregroundColor(.blue)
        }
    }
}

struct InfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanel(showInfos: Binding.constant(true)).environment(\.colorScheme, .light)
    }
}
