//
//  Color+RGBA.swift
//  Memorize
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import Foundation
import SwiftUI

extension Color {
    init(_ rgb: UIColor.RGB) {
    self.init(UIColor(rgb))
    }
}

 extension UIColor {
     public struct RGB: Hashable, Codable, CustomStringConvertible {
         var red: CGFloat
         var green: CGFloat
         var blue: CGFloat
         var alpha: CGFloat
         public var description: String {
            "R:\(String(format: "%.1f", Double(red))), G:\(String(format: "%.1f", Double(green))), B:\(String(format: "%.1f", Double(green)))"
         }
     }
    
     convenience init(_ rgb: RGB) {
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: rgb.alpha)
     }
    
     public var rgb: RGB {
         var red: CGFloat = 0
         var green: CGFloat = 0
         var blue: CGFloat = 0
         var alpha: CGFloat = 0
         getRed(&red, green: &green, blue: &blue, alpha: &alpha)
         return RGB(red: red, green: green, blue: blue, alpha: alpha)
    }

}

extension UIColor {
    static let gold: UIColor = UIColor(red: 255/255, green: 215/255, blue: 0, alpha: 1)
    static let varus: UIColor = UIColor(red: 0, green: 117/255, blue: 94/255, alpha: 1)
    static let varus2: UIColor = UIColor(red: 206/255, green: 103/255, blue: 166/255, alpha: 1)
    
    static let visibleWhite: UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    static let lightGray: UIColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
    static let darkGray: UIColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
    
    static let pastelCyan: UIColor = UIColor(red: 0, green: 243/255, blue: 224/255, alpha: 1)
    static let pastelGreen: UIColor = UIColor(red: 103/255, green: 206/255, blue: 166/255, alpha: 1)
    static let pastelCream: UIColor = UIColor(red: 254/255, green: 213/255, blue: 181/255, alpha: 1)
    static let pastelRed: UIColor = UIColor(red: 114/255, green: 12/255, blue: 63/255, alpha: 1)
    
    
    static let spruceBrown: UIColor = UIColor(red: 83/255, green: 52/255, blue: 0, alpha: 1)
    static let darkBrown: UIColor = UIColor(red: 85/255, green: 37/255, blue: 0, alpha: 1)
    
    static let darkPurple: UIColor = UIColor(red: 89/255, green: 24/255, blue: 70/255, alpha: 1)
    static let lavender: UIColor = UIColor(red: 230/255, green: 230/255, blue: 250/255, alpha: 1)
    static let violet: UIColor = UIColor(red: 238/255, green: 130/255, blue: 238/255, alpha: 1)
    static let mediumPurple: UIColor = UIColor(red: 147/255, green: 112/255, blue: 219/255, alpha: 1)
    
    static let lightPink: UIColor = UIColor(red: 1, green: 182/225, blue: 193/255, alpha: 1)
    static let slate: UIColor = UIColor(red: 89/225, green: 91/255, blue: 131/255, alpha: 1)
    static let darkSlate: UIColor = UIColor(red: 51/255, green: 52/255, blue: 86/255, alpha: 1)
    static let darkerSlate: UIColor = UIColor(red: 6/255, green: 9/255, blue: 46/255, alpha: 1)
    static let blueGray: UIColor = UIColor(red: 153/255, green: 168/255, blue: 178/255, alpha: 1)
}

