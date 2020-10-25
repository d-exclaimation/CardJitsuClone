//
//  ContentView.swift
//  Battle Cards
//
//  Created by Vincent on 9/24/20.
//

import SwiftUI

struct ContentView: View {
    
    // Primary Variables
    @ObservedObject var emojiCardGame: EmojiCardBattleGame
    var gameColor: Color
    var isDrag: Bool
    
    // Game State Quick Memory variables
    @State private var showBank: Bool = false
    @State private var movement: CGFloat = 0
    @State private var showAlert: Bool = false
    
    // MARK: - Drawing constant
    private let audio = SoundManager()
    private let textFontSize: CGFloat = 50
    private let tableOpacity: Color = Color.black.opacity(0.6)
    private let tablePads: CGFloat = 40
    private let cornerRad: CGFloat = 20
    private let gamePadding: [CGFloat] = [30, 5]
    private let cardSwing: CGFloat = 150
    
    // MARK: - Main View
    var body: some View {
        ZStack {
            setBackground() // Background method
            
            // Main UI/UX
            VStack {
                
                // Enemy Hand UI
                HStack{
                    ForEach(emojiCardGame.enemyHand) { card in
                        CardView(element: card.element, power: card.power, color: card.color, isFaceUp: false)
                    }
                    .transition(.scale)
                }
                
                // Table UI
                setBattleTable()
                    .onDrop(of: ["public.text"], isTargeted: nil) { providers, location in
                        self.drop(providers: providers)
                }
                
                // Player Hand UX
                HStack{
                    ForEach(emojiCardGame.playerHand) { card in
                        if isDrag {
                            setDropCard(card: card).transition(.scale)
                        } else {
                            setTapCard(card: card).transition(.offset(x: movement, y: -cardSwing))
                        }
                    }
                    
                }
                
                // Bank Buttons UX
                Button{
                    withAnimation(.easeInOut) {
                        showBank.toggle()
                        emojiCardGame.hidePlayer()
                    }
                } label: {
                    Text("My Bank")
                        .font(.body)
                        .buttonify(color: showBank ? Color.black : Color.white, size: .medium, fontColor: showBank ? Color.white : Color.black)
                }
                .offset(x: 0, y: 30)
                
                
            }
            .onAppear {
                audio.playSound(.shuffle)
            }
            .font(.system(size: textFontSize))
            .padding(gamePadding[0])
            .padding(.bottom, gamePadding[1])

            setUpBank()
        }
        
        // Alert and Hid Navigation bar
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            showAlert(title: emojiCardGame.endGame == .win ? "Win" : "Lose", message: "Reset Game?")
        }
    }
    
    
    
    // MARK: - Methods
    
    // Background methods with given gameColor
    @ViewBuilder private func setBackground() -> some View {
        // 3 rectangles at different angles
        Rectangle().foregroundColor(gameColor).ignoresSafeArea(.all)
        Rectangle().foregroundColor(.white).opacity(0.2).rotationEffect(Angle.degrees(9)).ignoresSafeArea(.all)
        Rectangle().foregroundColor(.white).opacity(0.1).rotationEffect(Angle.degrees(-69)).ignoresSafeArea(.all)
    }
    
    private func setTapCard(card: BattleSystem<Color, String>.Card) -> some View {
        CardView(element: card.element, power: card.power, color: card.color, isFaceUp: card.isFaceUp)
            .onTapGesture {
                chooseCard(card: card)
            }
    }
    
    private func setDropCard(card: BattleSystem<Color, String>.Card) -> some View {
        CardView(element: card.element, power: card.power, color: card.color, isFaceUp: card.isFaceUp)
            .onDrag {
                let uuid = card.id.uuidString
                return NSItemProvider(object: uuid as NSString)
            }
    }
    
    
    // MARK: - Banks
    
    // Setup Player Bank UI
    private func setUpBank() -> some View {
        GeometryReader { geometry in
            bankDisplay(item: emojiCardGame.playerBank, color: gameColor)
                .frame(width: geometry.size.width*0.9, height: geometry.size.height*0.9)
                .offset(x: geometry.size.width*0.05, y: showBank ? geometry.size.height*0.05 : geometry.size.height * 1.2)
        }
    }
    
    // Reusable Bank UI
    private func bankDisplay(item: [BattleSystem<Color, String>.Card], color: Color) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRad)
                .foregroundColor(color)
                .opacity(0.8)
            
            Grid(item) { card in
                CardView(element: card.element, power: card.power, color: card.color, isFaceUp: card.isFaceUp)
            }
        }
    }
    
   
    
    
    //  MARK: - Table View Methods
    
    // Table Logic
    private func tableLogo() -> some View {
        if emojiCardGame.wonRound {
            return IndicatorAlert(systemName: "checkmark.circle.fill", color: .green, scale: .medium)
        } else {
            return IndicatorAlert(systemName: "xmark.circle.fill", color: .red, scale: .medium)
        }
    }
    
    // Table UI Setup
    private func setBattleTable() -> some View {
        VStack {
            Spacer()
            HStack {
                tableSet(index: 0)
                Spacer()
                tableLogo()
                Spacer()
                tableSet(index: 1)
            }
            .padding()
            .background(tableOpacity)
            .cornerRadius(cornerRad)
            .padding(.horizontal, tablePads)
            Spacer()
        }
    }
    
    // Cards to display for the table
    private func tableSet(index: Int) -> CardView {
        CardView(element: emojiCardGame.currentTable[index].element, power:  emojiCardGame.currentTable[index].power, color:  emojiCardGame.currentTable[index].color, isFaceUp:  emojiCardGame.currentTable[index].isFaceUp)
    }
    
    
    
    
    //  MARK: - Game Misc
    
    // Alert Methods
    private func showAlert(title: String, message: String) -> Alert {
        if emojiCardGame.endGame == .win { audio.playSound(.match) }
        else { audio.playSound(.nomatch)}
        return Alert(title: Text(title), message: Text(message), dismissButton: Alert.Button.destructive(Text("Ok")) {
            // Show player current bank
            showBank.toggle()
            // Resets Game
            withAnimation(.easeInOut(duration: 0.2)) {
                emojiCardGame.resetGame()
                audio.playSound(.shuffle)
            }
        })
    }
    
    
    // MARK: - Action Methods
    
    private func chooseCard(card: BattleSystem<Color, String>.Card) {
        // Check if selected card is real
        guard let chosenCardIndex = emojiCardGame.playerHand.firstIndexOf(element: card) else {
            return
        }
        audio.playSound(.flip)
        // Calculate card animation given index
        cardMovement(for: chosenCardIndex)
        // Flip Table for cool effects
        emojiCardGame.flipTable()
        // With animation, notify the model that player has chosen a card
        withAnimation(.easeInOut) {
            emojiCardGame.choose(card: card)
            // Check whether game ended after model notified, and show bank and alert
            let gameEnded = emojiCardGame.endGame == .win || emojiCardGame.endGame == .lose
            showBank = gameEnded
            showAlert = gameEnded
        }
    }
    
    
    private func cardMovement(for id: Int) {
        // For each id specify x movement
        switch id {
            case 0:
                movement = 15
            case 1:
                movement = -10
            case 2:
                movement = -75
            case 3:
                movement = -150
            default:
                movement = 0
        }
    }
    
    // Method for finding dropped card
    private func drop(providers: [NSItemProvider]) -> Bool {
        // Since dropped item must be an NSItemProvider Array, it is best to extract loaded objects as a string
        let found = providers.loadObjects(ofType: String.self) { string in
            // If the string was a uuidString, it is possible to change back to UUID
            if let id = UUID(uuidString: string) {
                // Using the View Model to decide which card it is and notify the model
                withAnimation {
                    emojiCardGame.chooseIndex(id: id)
                    audio.playSound(.flip)
                    // Check whether game ended after model notified, and show bank and alert
                    let gameEnded = emojiCardGame.endGame == .win || emojiCardGame.endGame == .lose
                    showBank = gameEnded
                    showAlert = gameEnded
                }
            }
        }
        return found
    }
    
    // Optional: Use the view to decide which card it is. NOTE: The transition of the cardview require to be changed according
    private func decideCard(id: UUID) {
        // Call in the method for finding which card it is
        if let card = findSpecificCard(id: id) {
            // recall the same method for choosing regular card
            chooseCard(card: card)
        }
    }
    
    // Optional method if you want to preserve the animation
    private func findSpecificCard(id: UUID) -> BattleSystem<Color, String>.Card? {
        // Find the card, given an id, if not return nil
        for index in emojiCardGame.playerHand.indices {
            if id == emojiCardGame.playerHand[index].id {
                return emojiCardGame.playerHand[index]
            }
        }
        return nil
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(emojiCardGame: EmojiCardBattleGame(with: .art), gameColor: Color.black, isDrag: true)
    }
}
