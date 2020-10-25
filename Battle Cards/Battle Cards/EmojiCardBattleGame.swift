//
//  EmojiCardBattleGame.swift
//  Battle Cards
//
//  Created by Vincent on 9/24/20.
//

import Foundation
import SwiftUI

class EmojiCardBattleGame: ObservableObject {
    @Published private var battleCards: BattleSystem<Color, String>
    
    var gameTheme: BattleTheme
    
    init(with theme: BattleTheme) {
        gameTheme = theme
        battleCards = EmojiCardBattleGame.createNewGame(colors: theme.colorPicker.map { Color($0) }, elements: theme.elementPicker)
    }
    
    
    // MARK: - Static functions
    private static func createNewGame(colors: [Color], elements: [String]) -> BattleSystem<Color, String> {
        BattleSystem<Color, String>(makeColor: { colors[$0] }, makeElement: { elements[$0] })
    }

    
    // MARK: - Access
    var playerHand: [BattleSystem<Color, String>.Card] { battleCards.playerHand }
    var enemyHand: [BattleSystem<Color, String>.Card] { battleCards.enemyHand }
    var currentTable: [BattleSystem<Color, String>.Card] { battleCards.table }
    var playerBank: [BattleSystem<Color, String>.Card] { battleCards.playerBank }
    var wonRound: Bool { battleCards.wonTheRound }
    var endGame: BattleSystem<Color, String>.EndGame { battleCards.endTheGame }
    
    // MARK: - Intent
    func choose(card: BattleSystem<Color, String>.Card) {
        battleCards.choose(card: card, makeColor: { Color(gameTheme.colorPicker[$0]) }, makeElement: { gameTheme.elementPicker[$0] })
    }
    
    func chooseIndex(id: UUID) {
        for index in battleCards.playerHand.indices {
            if id == battleCards.playerHand[index].id {
                self.choose(card: battleCards.playerHand[index])
            }
        }
    }
    
    func hidePlayer() { battleCards.hidePlayerCard() }
    
    func flipTable() { battleCards.flipTable() }
    
    func resetGame() { battleCards = EmojiCardBattleGame.createNewGame(colors: gameTheme.colorPicker.map { Color($0) }, elements: gameTheme.elementPicker) }
}
