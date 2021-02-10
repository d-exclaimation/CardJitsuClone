//
//  ContentView.swift
//  Battle Cards
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
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
    private let tableOpacity: Double = 0.6
    private let tablePads: CGFloat = 40
    private let cornerRad: CGFloat = 20
    private let gamePadding: [CGFloat] = [-40, 5]
    private let cardSwing: CGFloat = 150
    
    // MARK: - Main View
    var body: some View {
        ZStack {
            setBackground() // Background method

            // Main UI/UX
            VStack {
        
                // Enemy Hand UI
                HStack {
                    ForEach(emojiCardGame.enemyHand) { card in
                        CardView(element: card.element, power: card.power, color: card.color, isFaceUp: false)
                    }
                    .transition(.scale)
                }
                
                // Table UI
                setBattleTable()
                    .onDrop(of: ["public.text"], isTargeted: nil) { providers, _ in
                        drop(providers: providers)
                }

                // Player Hand UX
                HStack {
                    ForEach(emojiCardGame.playerHand) { card in
                        if isDrag {
                            setDropCard(card: card).transition(AnyTransition.opacity
                                                                .combined(with: .offset(x: 0, y: -100)))
                        } else {
                            setTapCard(card: card).transition(AnyTransition.scale
                                                                .combined(with: .offset(x: 0, y: -100)))
                        }
                    }

                }

                // Bank Buttons UX
                Button {
                    withAnimation(.easeInOut) {
                        showBank.toggle()
                        emojiCardGame.hidePlayer()
                    }
                } label: {
                    Text("My Bank")
                        .font(.body)
                        // swiftlint:disable all
                        .buttonify(color: showBank ? .black : .white, size: .medium, fontColor: showBank ? .white : .black)
                }

            }
            .onAppear {
                audio.playSound(.shuffle)
            }
            .font(.system(size: textFontSize))
            .padding(.top, gamePadding[0])
            .padding(.bottom, gamePadding[1])

            BankWindowCard(showBank: $showBank, playerBank: emojiCardGame.playerBank, cornerRadius: cornerRad)
        }

        // Alert and Hid Navigation bar
        .navigationViewStyle(StackNavigationViewStyle())

        .alert(isPresented: $showAlert) {
            showAlert(title: emojiCardGame.endGame == .win ? "Win" : "Lose", message: "Reset Game?")
        }
    }

    // MARK: - Methods

    // Background methods with given gameColor
    @ViewBuilder private func setBackground() -> some View {
        // 3 rectangles at different angles
        Rectangle()
            .foregroundColor(gameColor)
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

    // MARK: - Table View Methods
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
            .background(Color.black.opacity(tableOpacity))
            .cornerRadius(cornerRad)
            .padding(.horizontal, tablePads)
            Spacer()
        }
    }
    // Cards to display for the table
    private func tableSet(index: Int) -> CardView {
        let card = emojiCardGame.currentTable[index]
        return CardView(element: card.element, power: card.power, color: card.color, isFaceUp: card.isFaceUp)
    }

    // MARK: - Game Misc
    // Alert Methods
    private func showAlert(title: String, message: String) -> Alert {
        if emojiCardGame.endGame == .win {
            audio.playSound(.match)
        } else { audio.playSound(.nomatch)}
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
        guard emojiCardGame.playerHand.firstIndex(of: card) != nil else {
            return
        }
        audio.playSound(.flip)

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

// Optional: Use the view to decide which card it is.
// NOTE: The transition of the cardview require to be changed according
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
        for index in emojiCardGame.playerHand.indices where id == emojiCardGame.playerHand[index].id {
            return emojiCardGame.playerHand[index]
        }
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(emojiCardGame: EmojiCardBattleGame(with: .art), gameColor: Color.black, isDrag: true)
    }
}
