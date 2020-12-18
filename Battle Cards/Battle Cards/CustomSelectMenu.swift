//
//  CustomSelectMenu.swift
//  Battle Cards
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import SwiftUI

struct CustomSelectMenu: View {
    
    // MARK: - Properties and Setup
    @Binding var draft: BattleTheme
    @Binding var themes: [BattleTheme]
    @State var name: String = ""
    @State var color: Color = Color.clear
    @State var element: String = ""
    
    // Progress out of 9
    @State var progress: Int = 0
    
    @State var newDraft: BattleTheme
    
    init(draft: Binding<BattleTheme>, themes: Binding<[BattleTheme]>) {
        _draft = draft
        _themes = themes
        _newDraft = State(wrappedValue: draft.wrappedValue)
    }
    
    
    // MARK: - Main UX
    var body: some View {
        
        // Progress Bar
        HStack {
            ProgressView(value: Double(progress) / 9)
        }
        
        // Editor depends on the progress count
        if progress == 0 {
            titleEditor
        } else if progress >= 1 && progress <= 4 {
            colorEditor(index: progress)
        } else if progress - 4 >= 1 && progress - 4 <= 3 {
            elementEditor(index: progress)
        } else if progress == 8 {
            backgroundEditor
        } else {
            resetMenu
        }
        
        // Preview Bar
        preview

        
    }
    
    var preview: some View {
        VStack {
            Text(newDraft.title)
                .font(.title)
                .bold()
            HStack {
                ForEach(0..<newDraft.colorPicker.count) { index in
                    Rectangle()
                        .foregroundColor(Color(UIColor(newDraft.colorPicker[index])))
                }
            }
            HStack {
                ForEach(newDraft.elementPicker, id:\.self) { emoji in
                    Text("[\(emoji)]")
                        .font(.title)
                }
            }
            Rectangle()
                .foregroundColor(Color(UIColor(newDraft.themeBackground)))
        }
    }
    
    // MARK: - Helper View
    var titleEditor: some View {
        VStack {
            Text("Insert name of theme")
                .font(.headline)
            HStack {
                TextField("Enter Name", text: $name)
                neatify(Text("Next"))
                    .font(.subheadline)
                    .foregroundColor(.green)
                    .onTapGesture {
                        withAnimation {
                            changeName(given: name)
                            name = ""
                        }
                    }
            }
        }
    }
    
    var backgroundEditor: some View {
        VStack {
            Text("Choose background color")
                .font(.headline)
            HStack {
                ColorPicker("Background", selection: $color)
                neatify(Text("Done"))
                    .font(.subheadline)
                    .foregroundColor(.orange)
                    .onTapGesture { withAnimation { changeBackground() } }
            }
        }
    }
    
    var resetMenu: some View {
        HStack {
            Spacer()
            neatify(Text("Reset"))
                .font(.headline)
                .foregroundColor(.red)
                .onTapGesture {
                    withAnimation {
                        progress = 0
                    }
                }
            Spacer()
        }
    }

    private func colorEditor(index: Int) -> some View {
        // TODO: Something here
        VStack {
            Text("Add Color \(index)#")
                .font(.headline)
            HStack {
                ColorPicker("\(UIColor(color).rgb.description)", selection: $color)
                neatify(Text("Next"))
                    .font(.subheadline)
                    .foregroundColor(.green)
                    .onTapGesture {
                        changeColor(index: index - 1, with: color)
                        color = Color.white
                    }
            }
        }
    }
    
    
    private func elementEditor(index: Int) -> some View {
        // TODO: Something here
        VStack {
            Text("Add Element \(index - 4)#")
                .font(.headline)
            HStack {
                TextField("Element \(index - 4)", text: $element)
                    .onChange(of: element, perform: { value in
                        if element.count > 0 {
                            element = String(element.first!)
                        }
                    })
                neatify(Text("Next"))
                    .font(.subheadline)
                    .foregroundColor(.green)
                    .onTapGesture {
                        changeElement(index: index - 5, with: element)
                        element = ""
                    }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(emojiPallete, id: \.self) { emoji in
                        Text("\(emoji)")
                            .onTapGesture { element = emoji }
                    }
                }
            }
        }
    }
    
    private func neatify(_ text: Text) -> some View {
        text
            .padding(5)
            .padding(.horizontal, 5)
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
    }
    
    
    // MARK: - Helper Methods
    private func changeName(given name: String) {
        newDraft = BattleTheme(name: name, colors: newDraft.colorPicker, elements: newDraft.elementPicker, background: newDraft.themeBackground)
        progress += 1
        color = Color(UIColor(newDraft.colorPicker[progress - 1]))
    }
    
    private func changeColor(index: Int, with color: Color) {
        
        // Get the array of all colors in the theme
        var temp = newDraft.colorPicker
        
        // Check for similar color
        for i in temp.indices {
            if temp[i] == UIColor(color).rgb && i != index { return }
        }
        
        withAnimation {
            
            // Set the current color from the index
            temp[index] = UIColor(color).rgb
            
            // Change the theme draft accordindly
            newDraft = BattleTheme(name: newDraft.title, colors: temp, elements: newDraft.elementPicker, background: newDraft.themeBackground)
            progress += 1
        }
    }
    
    
    private func changeElement(index: Int, with element: String) {
        
        // Get the array of all element in the theme
        var temp = newDraft.elementPicker
        
        // Check for duplications
        for i in temp.indices {
            if temp[i] == element && i != index { return }
        }
        
        withAnimation {
            
            // Set the current element shown using the index
            temp[index] = element
            
            // Change the theme draft accordindly
            newDraft = BattleTheme(name: newDraft.title, colors: newDraft.colorPicker, elements: temp, background: newDraft.themeBackground)
            progress += 1
        }
    }
    
    private func changeBackground() {
        newDraft = BattleTheme(name: newDraft.title, colors: newDraft.colorPicker, elements: newDraft.elementPicker, background: UIColor(color).rgb)
        save()
        progress += 1
    }
    
    private func save() {
        // Change the source draft to the currently edited one
        draft = newDraft
        
        // Append to the list of all themes, and redraw the selection
        BattleTheme.all.append(draft)
        themes = BattleTheme.all
    }
    
    private let emojiPallete: [String] = "😀😅😂😇🥰😉🙃😎🥳😡🤯🥶🤥😴🙄👿😷🤧🤡🍏🍎🥒🍞🥨🥓🍔🍟🍕🍰🍿☕️🐶🐼🐵🙈🙉🙊🦆🐝🕷🐟🦓🐪🦒🦨⚽️🏈⚾️🎾🏐🏓⛳️🥌⛷🚴‍♂️🎳🎼🎭🪂".map{ String($0) }
    
}


struct CustomSelectMenu_Previews: PreviewProvider {
    static var previews: some View {
        CustomSelectMenu(draft: Binding.constant(BattleTheme.aircraft), themes: Binding.constant(BattleTheme.all))
    }
}
