//
//  MainMenuView.swift
//  Battle Cards
//
//  Created by Vincent on 9/25/20.
//

import SwiftUI

struct MainMenuView: View {
    
    // MARK: - State variables for UX Interaction
    @State private var showSettings: Bool = false
    @State private var colorChoice: [Color] = [Color.orange, Color.yellow, Color.blue, Color.purple]
    @State private var elementChoice: [String] = ["🔥", "☘️", "💧"]
    @State private var gameBackground: Color = Color(red: 85/255, green: 37/255, blue: 0/255)
    
    // MARK: - Drawing Constants
    private let commonPads: CGFloat = 40
    private let uiOffSet: [CGFloat] = [0, -80]
    private let buttonScale: CGSize = CGSize(width: 1.4, height: 1.4)
    private let settingsScale: CGSize = CGSize(width: 1.2, height: 1.2)
    
    
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
                            }
                    }
                    Spacer()
                    // Copyright
                    Text(" Copyright © 2020 vincent. All rights reserved.")
                        .offset(x: uiOffSet[0], y: abs(uiOffSet[1]))
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .offset(x: uiOffSet[0], y: uiOffSet[1])
                
                setSettings()
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - View Methods
    
    // Regular background method
    @ViewBuilder private func setBackground() -> some View {
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
    
    // Create settings card given the geometry of device
    private func setSettings() -> some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.black)
                    .opacity(0.9)
                colorMenu()
            }
            .frame(width: geometry.size.width*0.9, height: geometry.size.height*0.9, alignment: .center)
            .offset(x: geometry.size.width*0.05, y: showSettings ? geometry.size.height*0.05 : 10000)
        }
    }
    
    // Settings UX Method
    private func colorMenu() -> some View {
        // Settings Main UX
        VStack {
            Spacer()
            Text("Choose theme") // Settings Title
                .font(.title)
                .foregroundColor(.white)
            Spacer()
            
            // Selections
            HStack {
                themeButton(element: "🎨", color: Color.purple, name: "Artistic")
                themeButton(element: "🇺🇸", color: Color.pink, name: "Freedom")
            }
            
            HStack {
                themeButton(element: "🏝", color: Color(red: 0, green: 243/255, blue: 224/255), name: "Tropical")
                themeButton(element: "🌌", color: Color.black, name: "Noir")
            }
            
            // Confirmation Button
            Button {
                withAnimation {
                    showSettings.toggle()
                }
            } label: {
                Text("Confirm")
                    .buttonify(color: Color.green, size: .medium)
            
            }
            .padding(commonPads)
        }
    }
    
    // Selection Button Method
    private func themeButton(element: String, color: Color, name: String) -> some View {
        VStack {
            CardView(element: element, power: 0, color: color, isFaceUp: true)
            Text(name)
                .foregroundColor(.white)
        }
        .padding(commonPads)
        .onTapGesture {
            // Call in the set them function given the parameters
            setTheme(theme: name.lowercased())
        }
    }
    
    // MARK: - Action Methods
    private func setTheme(theme: String) {
        // Decide depending on the given parameters
        switch theme.lowercased() {
            // Setup color choices, element choices, and game overall background color
            case "artistic":
                colorChoice = [Color.orange, Color.yellow, Color.blue, Color.purple]
                elementChoice = ["🔥", "☘️", "💧"]
                gameBackground = Color(red: 85/255, green: 37/255, blue: 0/255)
                break
            case "freedom":
                colorChoice = [Color.pink, Color(red: 230/255, green: 230/255, blue: 230/255), Color(red: 0/255, green: 23/255, blue: 144/255), Color.black]
                elementChoice = ["🔫", "🔪", "💸"]
                gameBackground = Color(red: 0, green: 0, blue: 100/255)
                break
            case "tropical":
                colorChoice = [Color.orange, Color.yellow, Color(red: 0, green: 243/255, blue: 224/255), Color(red: 254/255, green: 213/255, blue: 181/255)]
                elementChoice = ["🥵", "🥶", "😰"]
                gameBackground = Color(red: 0, green: 117/255, blue: 94/255)
                break
            case "noir":
                colorChoice = [Color.black, Color(red: 230/255, green: 230/255, blue: 230/255), Color(red: 100/255, green: 100/255, blue: 100/255), Color(red: 50/255, green: 50/255, blue: 50/255)]
                elementChoice = ["✂️", "📃", "🌑"]
                gameBackground = Color(red: 0.05, green: 0.05, blue: 0.05)
                break
            default:
                print("Fuck") // Should never have existed, It won't break anything but it might spawn more dangerous bug
        }
    }
    
    
    // Nagivation Destination method
    private func playGame() -> some View {
        ContentView(emojiCardGame: EmojiCardBattleGame(colors: colorChoice, elements: elementChoice), gameColor: gameBackground)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
