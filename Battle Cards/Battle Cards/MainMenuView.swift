//
//  MainMenuView.swift
//  Battle Cards
//
//  Created by Vincent on 9/25/20.
// Idk

import SwiftUI

struct MainMenuView: View {
    
    static let untitled = "MainMenuView.Untitled"
    
    // MARK: - State variables for UX Interaction
    @State private var showSettings: Bool = false
    @State private var showInfos: Bool = false
    @State private var chosenTheme: BattleTheme = BattleTheme.art
    @State private var isDrag: Bool
    
    // MARK: - Drawing Constants
    private let audio = SoundManager()
    private let commonPads: CGFloat = 40
    private let uiOffSet: [CGFloat] = [0, -40]
    private let buttonScale: CGSize = CGSize(width: 1.4, height: 1.4)
    private let settingsScale: CGSize = CGSize(width: 1.2, height: 1.2)
    private let smolScale: CGSize = CGSize(width: 0.8, height: 0.8)

    init() {
        let json: Data? = UserDefaults.standard.data(forKey: MainMenuView.untitled)
        if json != nil, let gesture = try? JSONDecoder().decode(Bool.self, from: json!) {
            _isDrag = State(wrappedValue: Bool(gesture))
        } else {
            _isDrag = State(wrappedValue: false)
        }
    }
    
    // MARK: Body View
    var body: some View {
        NavigationView {
            
            // Navigation Main menu
            ZStack {
                setBackground() // Background
                
                // Main UX/UI
                VStack {
                    Spacer()
                    // Title
                    Image("title")
                        .padding(.bottom, 90)
                        .scaleEffect(settingsScale)
                    
                    // Main Play Button
                    NavigationLink(
                        destination: playGame()) {
                        Image("play")
                            .padding(commonPads/1.5)
                            .scaleEffect(buttonScale)
                    }
                    
                    // Settings Button
                    Image("settings")
                        .padding(commonPads/1.5)
                        .scaleEffect(settingsScale)
                        .onTapGesture {
                            // Show settings menu
                            withAnimation {
                                showSettings.toggle()
                                audio.playSound(.flip)
                            }
                        }.sheet(isPresented: $showSettings, content: {
                            ThemeChooser(isPresented: $showSettings, theme: $chosenTheme, isDrag: $isDrag)
                        })
                    
                    // Information Button
                    Image("information")
                        .padding(commonPads/1.5)
                        .scaleEffect(settingsScale)
                        .onTapGesture {
                            // Show information menu
                            withAnimation {
                                showInfos.toggle()
                                audio.playSound(.flip)
                            }
                        }.sheet(isPresented: $showInfos, content: {
                            InfoPanel(showInfos: $showInfos)
                        })
                    
                    Spacer()
                    // Copyright
                    Text(" Copyright © 2020 vincent. All rights reserved.")
                        .offset(x: uiOffSet[0], y: abs(uiOffSet[1]))
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .offset(x: uiOffSet[0], y: uiOffSet[1])
                
            }
            .navigationBarHidden(true)
            LandScapeView(gameBackground: Color(chosenTheme.themeBackground))
        }
    }
    
    // MARK: - View Methods
    
    // Regular background method
    @ViewBuilder private func setBackground() -> some View {
        Rectangle()
            .foregroundColor(Color(chosenTheme.themeBackground))
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
    
    
    
    // Nagivation Destination method
    private func playGame() -> some View {
        ContentView(emojiCardGame: EmojiCardBattleGame(with: chosenTheme), gameColor: Color(chosenTheme.themeBackground), isDrag: isDrag)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
