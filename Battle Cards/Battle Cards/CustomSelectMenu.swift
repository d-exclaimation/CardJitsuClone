//
//  CustomSelectMenu.swift
//  Battle Cards
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import SwiftUI

struct CustomSelectMenu: View {
    
    @Binding var draft: BattleTheme
    @Binding var themes: [BattleTheme]
    @State var name: String = ""
    @State var color: Color = Color.clear
    @State var element: String = ""
    @State var progress: Int = 0
    @State var newDraft: BattleTheme
    
    init(draft: Binding<BattleTheme>, themes: Binding<[BattleTheme]>) {
        _draft = draft
        _themes = themes
        _newDraft = State(wrappedValue: draft.wrappedValue)
    }
    
    var body: some View {
        if progress == 0 {
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
                                newDraft = BattleTheme(name: name, colors: newDraft.colorPicker, elements: newDraft.elementPicker, background: newDraft.themeBackground)
                                name = ""
                                progress += 1
                                color = Color(UIColor(newDraft.colorPicker[progress - 1]))
                            }
                        }
                }
            }
        }
        
        if progress >= 1 && progress <= 4 {
            VStack {
                Text("Add colors for index of \(progress)")
                    .font(.headline)
                HStack {
                    ColorPicker("\(UIColor(color).rgb.description)", selection: $color)
                    neatify(Text("Next"))
                        .font(.subheadline)
                        .foregroundColor(.green)
                        .onTapGesture {
                            var temp = newDraft.colorPicker
                            withAnimation {
                                temp[progress - 1] = UIColor(color).rgb
                                newDraft = BattleTheme(name: newDraft.title, colors: temp, elements: newDraft.elementPicker, background: newDraft.themeBackground)
                                color = Color.clear
                                progress += 1
                                color = progress <= 4 ? Color(UIColor(newDraft.colorPicker[progress - 1])): Color(UIColor(newDraft.themeBackground))
                            }
                        }
                }
            }
        }
        
        if progress - 4 >= 1 && progress - 4 <= 3 {
            VStack {
                Text("Add element for index of \(progress - 4)")
                    .font(.headline)
                HStack {
                    TextField("Element \(progress - 4)", text: $element)
                        .onChange(of: element, perform: { value in
                            if element.count > 0 {
                                element = String(element.first!)
                            }
                        })
                    neatify(Text("Next"))
                        .font(.subheadline)
                        .foregroundColor(.green)
                        .onTapGesture {
                            var temp = newDraft.elementPicker
                            withAnimation {
                                temp[progress - 5] = element
                                newDraft = BattleTheme(name: newDraft.title, colors: newDraft.colorPicker, elements: temp, background: newDraft.themeBackground)
                                element = ""
                                progress += 1
                            }
                        }
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(emojiPallete, id: \.self) { emoji in
                            Text("\(emoji)")
                                .onTapGesture {
                                    element = emoji
                                }
                        }
                    }
                }
            }
        }
        
        if progress == 8 {
            VStack {
                Text("Choose background color")
                    .font(.headline)
                HStack {
                    ColorPicker("Background", selection: $color)
                    neatify(Text("Done"))
                        .font(.subheadline)
                        .foregroundColor(.orange)
                        .onTapGesture {
                            withAnimation {
                                newDraft = BattleTheme(name: newDraft.title, colors: newDraft.colorPicker, elements: newDraft.elementPicker, background: UIColor(color).rgb)
                                save()
                                progress += 1
                            }
                        }
                }
            }
        }
        
        if progress == 9 {
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
    
    private func neatify(_ text: Text) -> some View {
        text
            .padding(5)
            .padding(.horizontal, 5)
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
    }

    
    private func save() {
        draft = newDraft
        BattleTheme.all.append(draft)
        themes = BattleTheme.all
    }
    
    private let emojiPallete: [String] = "😀😅😂😇🥰😉🙃😎🥳😡🤯🥶🤥😴🙄👿😷🤧🤡🍏🍎🥒🍞🥨🥓🍔🍟🍕🍰🍿☕️🐶🐼🐵🙈🙉🙊🦆🐝🕷🐟🦓🐪🦒🦨⚽️🏈⚾️🎾🏐🏓⛳️🥌⛷🚴‍♂️🎳🎼🎭🪂".map{ String($0) }
}


//
//struct CustomSelectMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSelectMenu()
//    }
//}
//        ForEach(0..<colors.count) { index in
//            ColorPicker("Color \(index + 1)", selection: $colors[index])
//        }
//        VStack {
//            HStack {
//                Picker("Chosen Element", selection: $index) {
//                    ForEach(0..<elements.count) { i in
//                        Text(elements[i])
//                            .font(.system(size: 50))
//                            .tag(i)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//            }
//            TextField("Insert Emoji Here", text: $inputString, onEditingChanged: { began in
//                if !began {
//                    if inputString.count > 1 {
//                        inputString = String(inputString.first!)
//                    }
//                    elements[index] = inputString
//                    inputString = ""
//                }
//            })
//
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(emojiPallete, id: \.self) { emoji in
//                        Text("\(emoji)")
//                            .onTapGesture {
//                                if !elements.contains(emoji) {
//                                    elements[index] = emoji
//                                }
//                            }
//                    }
//                }
//            }
//        }
//        ColorPicker("Background Color", selection: $backgroundColor)
