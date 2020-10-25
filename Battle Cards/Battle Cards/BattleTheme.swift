//
//  BattleTheme.swift
//  Battle Cards
//
//  Created by Vincent on 10/24/20.
//

import Foundation
import SwiftUI

struct BattleTheme: Identifiable, Hashable {
    var title: String
    private(set) var id: UUID
    var colorPicker: [UIColor.RGB]
    var elementPicker: [String]
    var themeBackground: UIColor.RGB
    
    init(name: String = "Untitled", colors: [UIColor.RGB], elements: [String], background: UIColor.RGB) {
        title = name
        id = UUID()
        colorPicker = colors
        elementPicker = elements
        themeBackground = background
    }
    
    static func == (lhs: BattleTheme, rhs: BattleTheme) -> Bool {
            return lhs.id == rhs.id
    }
    
    static var all: [BattleTheme] = [.art, .murica, .pastel, .noir, .covid, .pacman, .wildwest, .physics, .math, .idk]
    
    static var art: BattleTheme = BattleTheme(
        name: "artistic",
        colors: [UIColor.systemOrange.rgb, UIColor.gold.rgb, UIColor.systemBlue.rgb, UIColor.systemPurple.rgb],
        elements: ["🔥", "☘️", "💧"],
        background: UIColor.darkBrown.rgb
    )
    
    static var murica: BattleTheme = BattleTheme(
        name: "murica",
        colors: [UIColor.visibleWhite.rgb, UIColor.systemIndigo.rgb, UIColor.black.rgb, UIColor.systemPink.rgb],
        elements: ["🔫", "🔪", "💸"],
        background: UIColor.red.rgb
    )
    
    static var pastel: BattleTheme = BattleTheme(
        name: "tropical",
        colors: [UIColor.gold.rgb, UIColor.pastelGreen.rgb, UIColor.pastelCream.rgb, UIColor.pastelCyan.rgb],
        elements: ["🥵", "🥶", "😰"],
        background: UIColor.pastelCream.rgb
    )
    
    static var noir: BattleTheme = BattleTheme(
        name: "noir",
        colors: [UIColor.black.rgb, UIColor.darkGray.rgb, UIColor.visibleWhite.rgb, UIColor.lightGray.rgb],
        elements: ["✂️", "📃", "🌑"],
        background: UIColor.black.rgb
    )
    
    static var covid: BattleTheme = BattleTheme(
        name: "Outbreak",
        colors: [UIColor.systemOrange.rgb ,UIColor.systemRed.rgb, UIColor.varus.rgb, UIColor.varus2.rgb],
        elements: ["🦠", "👤", "💉"],
        background: UIColor.varus.rgb
    )
    
    static var pacman: BattleTheme = BattleTheme(
        name: "Retro",
        colors: [UIColor.systemIndigo.rgb, UIColor.lightGray.rgb, UIColor.black.rgb ,UIColor.gold.rgb],
        elements: ["😶", "👾", "👻"],
        background: UIColor.systemIndigo.rgb
    )
   
    static var wildwest: BattleTheme = BattleTheme(
        name: "Cowboys",
        colors: [UIColor.spruceBrown.rgb, UIColor.gold.rgb, UIColor.systemOrange.rgb ,UIColor.brown.rgb],
        elements: ["🤠", "🐎", "💰"],
        background: UIColor.brown.rgb
    )
    
    static var physics: BattleTheme = BattleTheme(
        name: "Physics",
        colors: [UIColor.gold.rgb, UIColor.systemOrange.rgb, UIColor.systemRed.rgb, UIColor.pastelRed.rgb],
        elements: ["💎", "🧪", "💨"],
        background: UIColor.darkPurple.rgb
    )
    
    static var math: BattleTheme = BattleTheme(
        name: "Maths",
        colors: [UIColor.violet.rgb, UIColor.systemPurple.rgb, UIColor.lavender.rgb, UIColor.mediumPurple.rgb],
        elements: ["✖️", "➗", "➕"],
        background: UIColor.mediumPurple.rgb
    )
    
    static var idk: BattleTheme = BattleTheme(
        name: "I gave up",
        colors: [UIColor.black.rgb, UIColor.systemRed.rgb, UIColor.gold.rgb, UIColor.systemBlue.rgb],
        elements: ["🌀", "🔆", "💢"],
        background: UIColor.systemBlue.rgb
    )
}

extension UIColor {
    static var gold: UIColor = UIColor(red: 255/255, green: 215/255, blue: 0, alpha: 1)
    static var varus: UIColor = UIColor(red: 0, green: 117/255, blue: 94/255, alpha: 1)
    static var varus2: UIColor = UIColor(red: 206/255, green: 103/255, blue: 166/255, alpha: 1)
    
    static var visibleWhite: UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    static var lightGray: UIColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
    static var darkGray: UIColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
    
    static var pastelCyan: UIColor = UIColor(red: 0, green: 243/255, blue: 224/255, alpha: 1)
    static var pastelGreen: UIColor = UIColor(red: 103/255, green: 206/255, blue: 166/255, alpha: 1)
    static var pastelCream: UIColor = UIColor(red: 254/255, green: 213/255, blue: 181/255, alpha: 1)
    static var pastelRed: UIColor = UIColor(red: 114/255, green: 12/255, blue: 63/255, alpha: 1)
    
    
    static var spruceBrown: UIColor = UIColor(red: 83/255, green: 52/255, blue: 1, alpha: 1)
    static var darkBrown: UIColor = UIColor(red: 85/255, green: 37/255, blue: 0/255, alpha: 1)
    
    static var darkPurple: UIColor = UIColor(red: 89/255, green: 24/255, blue: 70/255, alpha: 1)
    static var lavender: UIColor = UIColor(red: 230/255, green: 230/255, blue: 250/255, alpha: 1)
    static var violet: UIColor = UIColor(red: 238/255, green: 130/255, blue: 238/255, alpha: 1)
    static var mediumPurple: UIColor = UIColor(red: 147/255, green: 112/255, blue: 219/255, alpha: 1)
}
