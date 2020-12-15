//
//  BattleSystem.swift
//  Battle Cards
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import Foundation

struct BattleSystem<Color, Element> where Color: Equatable, Element: Equatable {
    // Player systems
    private(set) var playerHand: [Card]
    private(set) var playerBank: [Card]
    
    // Enemy systems
    private(set) var enemyHand: [Card]
    private var enemyBank: [Card]
    
    // Table
    private(set) var table: [Card]
    private(set) var wonTheRound: Bool = false
    private(set) var endTheGame: EndGame = .neither
    
    enum EndGame {
        case win
        case lose
        case neither
    }
    
    
// MARK: - Core Methods
    
    init(makeColor: (Int) -> Color, makeElement: (Int) -> Element) {
        // Initialize all element
        playerBank = [Card]()
        enemyBank = [Card]()
        table = [Card(element: makeElement(0), indicator: .paper, power: 0, color: makeColor(0)), Card(element: makeElement(0), indicator: .paper, power: 0, color: makeColor(0))]
        
        playerHand = [Card]()
        enemyHand = [Card]()
        
        
        for turn in 0...1 {
            for _ in 0..<4 {
                
                // Create card
                let newCard = createCard(makeColor: makeColor, makeElement: makeElement)
                
                // Add to respective hand
                if turn == 0 { playerHand.append(newCard) }
                else { enemyHand.append(newCard)}
                
            }
        }
        
    }
    
    mutating func choose(card: Card, makeColor: (Int) -> Color, makeElement: (Int) -> Element) {
        if let cardIndex: Int = playerHand.firstIndexOf(element: card) {
            // Retrieve card from hand
            let chosen = playerHand.remove(at: cardIndex)
            
            // Set the table with retrieved cards
            setTable(playerCard: chosen, enemyChoice: Int.random(in: 0..<enemyHand.count))
            
            // Add new cards in
            playerHand.append(createCard(makeColor: makeColor, makeElement: makeElement))
            enemyHand.append(createCard(makeColor: makeColor, makeElement: makeElement))
            
            // Check who won the table
            checkRound()
            
            // Check who won the game
            checkWin()
        }
    }
    
    mutating func setTable(playerCard: Card, enemyChoice: Int) {
        table = [playerCard, enemyHand.remove(at: enemyChoice)]
        
    }
    
    mutating func flipTable() {
        for i in table.indices {
            table[i].isFaceUp = false
        }
    }
    
    mutating func hidePlayerCard() {
        for i in playerHand.indices {
            playerHand[i].isFaceUp.toggle()
        }
    }
  
// MARK: - Support Methods
    mutating private func checkRound() {
        if table[0] == table[1] { drawMode() }
        else if table[0] > table[1] { winMode() }
        else if table[0] < table[1] { loseMode() }
    }
    
    mutating private func winMode() {
        playerBank.append(table[0])
        wonTheRound = true
    }
    
    mutating private func loseMode() {
        enemyBank.append(table[1])
        wonTheRound = false
    }
    
    mutating private func drawMode() {
        if table[1].power > table[0].power {
            loseMode()
        } else {
            winMode()
        }
    }
    
    // MARK: - End Game Methods
    mutating private func checkWin() {
        
        if checkForColorVariety(for: playerBank) || checkForElementVariety(for: playerBank){
            endTheGame = .win

        } else if checkForColorVariety(for: enemyBank) || checkForElementVariety(for: enemyBank){
            endTheGame = .lose
            
        } else {
            endTheGame = .neither
        }
    }
    
    private func checkForElementVariety(for arr: [Card]) -> Bool {
        if arr.count < 3 {
            return false
        } else {
            for i in arr.indices {
                var newArr = [arr[i]]
                for j in arr.indices {
                    if findUniqueCards(from: newArr, for: arr[j]) {
                        newArr.append(arr[j])
                    }
                }
                
                if newArr.count == 3 { return true }
            }
            return false
        }
    }
    
    private func findUniqueCards(from arr: [Card], for card: Card) -> Bool {
        for i in arr.indices {
            if arr[i].color == card.color || arr[i].element == card.element {
                return false
            }
        }
        return true
    }
    
    private func checkForColorVariety(for arr: [Card]) -> Bool {
        if arr.count < 3 {
            return false
        } else {
            let allRPS: [Card.RPS] = [.scissors, .paper, .rock]
            for i in allRPS {
                var newArr = [Color]()
                for index in arr.indices {
                    if arr[index].indicator == i && !newArr.contains(arr[index].color) {
                        newArr.append(arr[index].color)
                    }
                }
                if newArr.count == 3 { return true }
            }
            return false
        }
    }
    
    
    private func createCard(makeColor: (Int) -> Color, makeElement: (Int) -> Element) -> Card {
        // Set all variables for Card
        let i = Int.random(in: 0...2)
        let newI: Card.RPS = i == 0 ? .scissors : i == 1 ? .paper : .rock
        let e = makeElement(i)
        let c = makeColor(Int.random(in: 0...3))
        let p = Int.random(in: 1...15)
        // Create card
        return Card(element: e, indicator: newI, power: p > 10 ? 10 - ((p - 10) / 2): p, color: c, isFaceUp: true)
    }
    
 
// MARK: - Cards
    
    struct Card: Identifiable, CustomStringConvertible, Equatable, Comparable {
        let id = UUID()
        let element: Element
        let indicator: Card.RPS
        let power: Int
        let color: Color
        var isFaceUp = false
        
        enum RPS {
            case scissors
            case paper
            case rock
        }
        
        var description: String {
            "Card of \(indicator), with power \(power)"
        }
        
        static public func == (lhs: Card, rhs: Card) -> Bool {
            lhs.indicator == rhs.indicator
        }
        
        static public func > (lhs: Card, rhs: Card) -> Bool {
            switch lhs.indicator {
                case .scissors:
                    return rhs.indicator == .paper
                case .paper:
                    return rhs.indicator == .rock
                case .rock:
                    return rhs.indicator == .scissors
            }
        }
        
        static public func < (lhs: Card, rhs: Card) -> Bool {
            switch lhs.indicator {
                case .scissors:
                    return rhs.indicator == .rock
                case .paper:
                    return rhs.indicator == .scissors
                case .rock:
                    return rhs.indicator == .paper
            }
        }
    }
    
}
