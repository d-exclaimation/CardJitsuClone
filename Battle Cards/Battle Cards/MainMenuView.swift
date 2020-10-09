//
//  MainMenuView.swift
//  Battle Cards
//
//  Created by Vincent on 9/25/20.
// Idk

import SwiftUI

struct MainMenuView: View {
    
    static private let untitled = "MainMenuView.Untitled"
    
    // MARK: - State variables for UX Interaction
    @State private var showSettings: Bool = false
    @State private var showInfos: Bool = false
    @State private var colorChoice: [Color] = [Color.orange, Color.yellow, Color.blue, Color.purple]
    @State private var elementChoice: [String] = ["🔥", "☘️", "💧"]
    @State private var gameBackground: Color = Color(red: 85/255, green: 37/255, blue: 0/255)
    @State private var isDrag: Bool = false {
        didSet {
            let json = try? JSONEncoder().encode(isDrag)
            UserDefaults.standard.set(json, forKey: MainMenuView.untitled)
        }
    }
    @State private var settingType: String = "neither"
    
    // MARK: - Drawing Constants
    private let commonPads: CGFloat = 40
    private let uiOffSet: [CGFloat] = [0, -40]
    private let buttonScale: CGSize = CGSize(width: 1.4, height: 1.4)
    private let settingsScale: CGSize = CGSize(width: 1.2, height: 1.2)
    private let smolScale: CGSize = CGSize(width: 0.8, height: 0.8)

    
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
                            }
                    }
                    
                    // Information Button
                    Image("information")
                        .padding(commonPads/1.5)
                        .scaleEffect(settingsScale)
                        .onTapGesture {
                            // Show settings menu
                            withAnimation {
                                showInfos.toggle()
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
                infoMenu()
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
                chooseWhichToAdjust()
            }
            .frame(width: geometry.size.width*0.9, height: geometry.size.height*0.9, alignment: .center)
            .offset(x: geometry.size.width*0.05, y: showSettings ? geometry.size.height*0.05 : geometry.size.height*2)
        }
    }
    
    // Setting Selection
    @ViewBuilder private func chooseWhichToAdjust() -> some View {
        
        // Pre-settings menu
        VStack {
            Text("Choose settings") // Settings Title
                .font(.title)
                .foregroundColor(.white)
            Button{
                let json: Data? = UserDefaults.standard.data(forKey: MainMenuView.untitled)
                if json != nil, let gesture = try? JSONDecoder().decode(Bool.self, from: json!) {
                    self.isDrag = gesture
                } else {
                    self.isDrag = true
                }
                withAnimation {
                    settingType = "gestures"
                }
            } label: {
                Image("gesture")
                    .scaleEffect(smolScale)
            }
            .padding(commonPads)
            
            Button{
                withAnimation {
                    settingType = "theme"
                }
            } label: {
                Image("themes")
                    .scaleEffect(smolScale)
            }
            .padding(commonPads)
            
            
            
        }
        .opacity( settingType == "neither" ? 1 : 0)
        
        gesturesMenu().opacity( settingType == "gestures" ? 1 : 0)
        
        colorMenu().opacity( settingType == "theme" ? 1 : 0)
        
    }
    
    // Theme Settings UX Method
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
                    settingType = "neither"
                }
            } label: {
                Text("Confirm")
                    .buttonify(color: Color.green, size: .medium)
            
            }
            .padding(commonPads)
        }
    }
    
    // Gestures Selection UX
    private func gesturesMenu() -> some View {
        VStack {
            Spacer()
            Text("Choose gestures") // Title
                .font(.title)
                .foregroundColor(.white)
            Spacer()
            
            // Options
            HStack {
                SFIcon(systemName: "cursorarrow.rays", with: Color(red: 0, green: 1, blue: 1), named: "Tap") {
                    isDrag = false
                }
                .scaleEffect(1.5)
                .padding(commonPads/1.5)
                    
                
                SFIcon(systemName: "cursorarrow.motionlines", with: Color(red: 1, green: 0, blue: 1), named: "Drop") {
                    isDrag = true
                }
                .scaleEffect(1.5)
                .padding(commonPads/1.5)
            }
            
            Spacer()
            
            // Confirmation Button
            Button {
                withAnimation {
                    showSettings.toggle()
                    settingType = "neither"
                }
            } label: {
                Text("Confirm")
                    .buttonify(color: Color.green, size: .medium)
            
            }
            .padding(commonPads)
            
        }
    }
    
    // Info UI
    private func infoMenu() -> some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.black)
                    .opacity(0.9)
                VStack {
                    
                    VStack {
                        Text("Information")
                            .font(.title)
                            .bold()
                        Text("This game is copy of the game Crad Jitsu from Club Penguin, Made into Mobile App")
                    }
                    .padding()
                    
                    Text("How to play")
                        .font(.title)
                        .bold()
                    VStack(alignment: .leading) {
                        Text("The goal of the game is collect cards in a specific way in your bank")
                        Text("The winning collection must be either one of these:")
                        Text("- 3 Cards with Different Elements and Colors")
                            .foregroundColor(Color(red: 0, green: 1, blue: 1))
                        Text("- 3 Cards with Same Elements, yet Different Colors")
                            .foregroundColor(Color(red: 1, green: 1, blue: 0.5))
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                Text("To collect cards and put in the")
                                Text(" bank")
                                    .foregroundColor(Color(red: 0, green: 1, blue: 0.4))
                                Text(", You have ")
                            }
                            HStack(spacing: 0) {
                                Text("to ")
                                Text("win")
                                    .foregroundColor(Color(red: 0, green: 1, blue: 0.8))
                                Text(" with the card. Winning the card is very")
                            }
                            Text("simple, just choose one from your hand.")
                        }
                        VStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                Text("Chosen card")
                                    .foregroundColor(Color(red: 1, green: 0, blue: 1))
                                Text(" will be put in the table, where it ")
                            }
                            HStack(spacing: 0) {
                                Text("will be matched against ")
                                Text("your opponent's. ")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.vertical, 10)
                        VStack(alignment: .leading) {
                            Text("In order to win with the card, your card must")
                            HStack(spacing: 0) {
                                Text("either have an ")
                                Text("element advantages")
                                    .foregroundColor(.purple)
                                Text(", or the same")
                            }
                            HStack(spacing: 0) {
                                Text("element, yet ")
                                Text("higher in value.")
                                    .foregroundColor(Color(red: 1, green: 0, blue: 0.4))
                            }
                            HStack(spacing: 0) {
                                Text("Co")
                                    .foregroundColor(Color(red: 1, green: 0.4, blue: 0.8))
                                Text("lo")
                                    .foregroundColor(Color(red: 0.8, green: 1, blue: 0.4))
                                Text("rs")
                                    .foregroundColor(Color(red: 0.4, green: 0.8, blue: 1))
                                Text(" doesn't play an effect here")
                            }
                        }
                        
                    }
                    .padding()
                    
                    Text("Element Advantages")
                        .bold()
                    GeometryReader { geometry in
                        HStack {
                            Image("art")
                                .resizable()
                                .frame(width: min(geometry.size.height, geometry.size.width)/1.5, height: min(geometry.size.height, geometry.size.width)/1.5)
                            Image("murica")
                                .resizable()
                                .frame(width: min(geometry.size.height, geometry.size.width)/1.5, height: min(geometry.size.height, geometry.size.width)/1.5)
                            Image("tropical")
                                .resizable()
                                .frame(width: min(geometry.size.height, geometry.size.width)/1.5, height: min(geometry.size.height, geometry.size.width)/1.5)
                            Image("noir")
                                .resizable()
                                .frame(width: min(geometry.size.height, geometry.size.width)/1.5, height: min(geometry.size.height, geometry.size.width)/1.5)
                        }.offset(x: geometry.size.width*0.075, y: 0)
                    }
                    
                    
                    
                    
                    Button {
                        showInfos.toggle()
                    } label: {
                        Text("Done").buttonify(color: Color.red, size: .small)
                    }
                    .padding()
                }
                .font(.subheadline)
                .foregroundColor(.white)
            }
            .frame(width: geometry.size.width*0.9, height: geometry.size.height*0.9, alignment: .center)
            .offset(x: geometry.size.width*0.05, y: showInfos ? geometry.size.height*0.05 : -geometry.size.height*2)
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
        return ContentView(emojiCardGame: EmojiCardBattleGame(colors: colorChoice, elements: elementChoice), gameColor: gameBackground, isDrag: isDrag)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
