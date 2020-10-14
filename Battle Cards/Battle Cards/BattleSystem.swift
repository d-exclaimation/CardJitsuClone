//
//  BattleSystem.swift
//  Battle Cards
//
//  Created by Vincent on 9/24/20.
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
        table = [Card(element: makeElement(0), indicator: 0, power: 0, color: makeColor(0)), Card(element: makeElement(0), indicator: 0, power: 0, color: makeColor(0))]
        
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
        switch table[0].indicator {
            case 0:
                switch table[1].indicator {
                    case 0:
                        self.drawMode()
                    case 1:
                        self.winMode()
                    case 2:
                        self.loseMode()
                    default:
                        // Fuck
                        print("Something is fucked")
                }
            case 1:
                switch table[1].indicator {
                    case 0:
                        self.loseMode()
                    case 1:
                        self.drawMode()
                    case 2:
                        self.winMode()
                    default:
                        // Fuck
                        print("Something is fucked")
                }
            case 2:
                switch table[1].indicator {
                    case 0:
                        self.winMode()
                    case 1:
                        self.loseMode()
                    case 2:
                        self.drawMode()
                    default:
                        // Fuck
                        print("Something is fucked")
                }
            default:
                // Fuck
                print("Something is fucked")
        }
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
            self.loseMode()
        } else {
            self.winMode()
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
            for i in 0...2 {
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
        let e = makeElement(i)
        let c = makeColor(Int.random(in: 0...3))
        let p = Int.random(in: 1...10)
        
        // Create card
        return Card(element: e, indicator: i, power: p, color: c, isFaceUp: true)
    }
    
 
// MARK: - Cards
    
    struct Card: Identifiable {
        let id = UUID()
        let element: Element
        let indicator: Int
        let power: Int
        let color: Color
        var isFaceUp = false
    }
    
}
