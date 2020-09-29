//
//  EmojiCardBattleGame.swift
//  Battle Cards
//
//  Created by Vincent on 9/24/20.
//

import Foundation
import SwiftUI

class EmojiCardBattleGame: ObservableObject {
    @Published private var battleCards: BattleSystem<Color, String> = createNewGame()
    
    static var colorPicker: [Color] = [Color.orange, Color.yellow, Color.blue, Color.purple]
    
    static var elementPicker: [String] = ["🔥", "☘️", "💧"]
    
    
    init(colors: [Color] = [Color.orange, Color.yellow, Color.blue, Color.purple], elements: [String] = ["🔥", "☘️", "💧"]) {
        EmojiCardBattleGame.colorPicker = colors
        EmojiCardBattleGame.elementPicker = elements
    }
    
    
    // MARK: - Static functions
    private static func createNewGame() -> BattleSystem<Color, String> {
        BattleSystem<Color, String>(makeColor: colorPicker(_:), makeElement: elementPicker(_:))
    }
    
    private static func colorPicker(_ index: Int) -> Color {
        return colorPicker[index]
    }
    
    private static func elementPicker(_ index: Int) -> String {
        return elementPicker[index]
    }
    
    
    // MARK: - Access
    var playerHand: [BattleSystem<Color, String>.Card] { battleCards.playerHand }
    var enemyHand: [BattleSystem<Color, String>.Card] { battleCards.enemyHand }
    var currentTable: [BattleSystem<Color, String>.Card] { battleCards.table }
    var playerBank: [BattleSystem<Color, String>.Card] { battleCards.playerBank }
    var enemyBank: [BattleSystem<Color, String>.Card] { battleCards.enemyBank }
    var wonRound: Bool { battleCards.wonTheRound }
    var endGame: BattleSystem<Color, String>.EndGame { battleCards.endTheGame }
    
    // MARK: - Intent
    func choose(card: BattleSystem<Color, String>.Card) {
        battleCards.choose(card: card, makeColor: EmojiCardBattleGame.colorPicker(_:), makeElement: EmojiCardBattleGame.elementPicker(_:))
    }
    
    func hidePlayer() { battleCards.hidePlayerCard() }
    
    func flipTable() { battleCards.flipTable() }
    
    func resetGame() { battleCards = EmojiCardBattleGame.createNewGame() }
}
