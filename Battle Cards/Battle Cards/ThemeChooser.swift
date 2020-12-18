//
//  ThemeChooser.swift
//  Battle Cards
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import SwiftUI

struct ThemeChooser: View {
    
    @Binding var isPresented: Bool
    @Binding var theme: BattleTheme
    @Binding var isDrag: Bool
    @State var themes: [BattleTheme] = BattleTheme.all
    @State private var themeDraft: BattleTheme
    @State private var gestureDraft: Bool
    private let audio: SoundManager = SoundManager()
    
    init(isPresented: Binding<Bool>, theme: Binding<BattleTheme>, isDrag: Binding<Bool>) {
        _theme = theme
        _isDrag = isDrag
        _isPresented = isPresented
        _themeDraft = State(wrappedValue: theme.wrappedValue)
        _gestureDraft = State(wrappedValue: isDrag.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Theme Picker"), footer: Text("New ones will be added soon")) {
                    Picker("Theme", selection: $themeDraft) {
                        ForEach(themes) { theme in
                            Text("\(theme.title.capitalized()) \(theme.elementPicker.compressed)")
                                .foregroundColor(Color(theme.colorPicker.last ?? theme.themeBackground))
                                .tag(theme)
                        }
                    }
                }
                Section(header: Text("Gesture options")) {
                    Picker("Gesture", selection: $gestureDraft) {
                        HStack {
                            Image(systemName: "cursorarrow.motionlines")
                            Text("Drag")
                        }
                        .foregroundColor(Color(red: 0, green: 1, blue: 1))
                        .tag(true)
                        HStack {
                            Image(systemName: "cursorarrow.rays")
                            Text("Tap")
                        }
                        .foregroundColor(.pink)
                        .tag(false)
                    }
                }
                
                Section(header: Text("Custom Theme")) {
                    CustomSelectMenu(draft: $themeDraft, themes: $themes)
                }
            }
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(leading: cancel, trailing: confirm)
        }
    }
    
    var cancel: some View {
        Button {
            audio.playSound(.nomatch)
            isPresented.toggle()
        } label: {
            Text("Cancel")
                .foregroundColor(.red)
        }
    }
    
    var confirm: some View {
        Button {
            theme = themeDraft
            isDrag = gestureDraft
            saveAll()
            audio.playSound(.match)
            isPresented.toggle()
        } label: {
            Text("Done")
                .foregroundColor(.blue)
        }
    }
    
    private func saveAll() {
        saveThemes()
        saveGesture()
        saveChoosen()
    }
    
    private func saveGesture() {
        let json = try? JSONEncoder().encode(isDrag)
        UserDefaults.standard.set(json, forKey: MainMenuView.untitled)
    }
    
    private func saveThemes() {
        let file = try? JSONEncoder().encode(BattleTheme.all)
        UserDefaults.standard.set(file, forKey: MainMenuView.allThemes)
    }
    
    private func saveChoosen() {
        UserDefaults.standard.set(theme.json, forKey: MainMenuView.currentTheme)
    }

}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser(isPresented: Binding.constant(false), theme: Binding.constant(BattleTheme.noir), isDrag: Binding.constant(false)).environment(\.colorScheme, .dark)
    }
}
