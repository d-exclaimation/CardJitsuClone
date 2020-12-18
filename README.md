# BattleCards / CardJitsuClone
I make a simple Card Jitsu Game Clone for iOS using SwiftUI MVVM

# Game Mechanics
3 Steps of the game
> 1. Use a card
> 2. Win a card in a duel
> 3. Collect the right collection of cards

Each player will have 5 cards dealt randomly, and can only use one per turn
## Cards
Cards have 3 attributes or properties
- Color
- Element
- Power
This represent the card itself and its odd to win when you use it
### Win a card
Winning a card goes through 2 simple checks
> 1. Check if the element has an advantage
> 2. Check if the power number is larger

A won card will be sent to their respective owner's bank or collection

Note that `Color does not play an effect here`
## Banks
Banks are the collection of all won cards
> This can be accessed through the Show Bank Button

Collection system creates a new complexity within the game rather than a simple score

Winning a single card is fun, but is too simple and get boring too quickly

Instead, winning is determined with a certain scenarios
### Winning Collection
Two ways to win, both require 3 cards at least
> 1. 3 Unique cards with unique colors and unique elements
> 2. 3 Unique cards with unique colors but the same elements

# Builds
The App is only avaiable on Apple Devices

Other platforms is coming soon but will be a different project

## macOS
Finished App
> Open the app in the Builds folder

Build in Xcode
> 1. Open the Xcode project in Xcode
> 1. Alternatively, you can open the project from the terminal using:
```shell
$ xed Battle\ Cards/Battle\ Cards.xcodeproj
```
> 2. Run the project

## iOS and iPadOS
Build in Xcode
> 1. Open the Xcode project in Xcode
> 1. Alternatively, you can open the project from the terminal using:
```shell
$ xed Battle\ Cards/Battle\ Cards.xcodeproj
```
> 2. Run the project

App Store `Not quite there yet`

## watchOS and tvOS

`Not available yet aka coming soon`


# Codes

I mainly stick to an MVVM architecture as this is the project to embolden my MVVM skills

Examples:

```swift
struct BattleSystem<Color, Element> where Color: Equatable, Element: Equatable {
    private(set) var playerHand: [Card]
    private(set) var playerBank: [Card]

    private(set) var enemyHand: [Card]
    private var enemyBank: [Card]
    
    private(set) var table: [Card]
    private(set) var wonTheRound: Bool = false
    private(set) var endTheGame: EndGame = .neither
    
    enum EndGame {
        case win
        case lose
        case neither
    }
    
    ...
    
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
 
        ...
    }
}
```

```swift
struct BattleTheme: Identifiable, Hashable, CustomStringConvertible, Codable {
    var title: String
    private(set) var id: UUID
    var colorPicker: [UIColor.RGB]
    var elementPicker: [String]
    var themeBackground: UIColor.RGB
    
    ...
}
```
You can check the rest in the source code

Most of code were purely from me. However, some of them were not, but all of them were licensed with the permission for commercial use.

```swift
struct UIColor.RGB { ... }
struct GridSystem { ... }
struct Grid { ... }
```

# Lastly

```swift
func main() {
   print("Hello \(you), Enjoy the app!")
}

main()
```

The MIT License (MIT)
Copyright © 2020 d-exclaimation
