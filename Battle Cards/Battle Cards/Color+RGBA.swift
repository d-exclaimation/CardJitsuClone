//
//  Color+RGBA.swift
//  Memorize
//
//  Created by Vincent on 10/14/20.
//  Copyright © 2020 Vincent. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    init(_ rgb: UIColor.RGB) {
    self.init(UIColor(rgb))
    }
}

 extension UIColor {
     public struct RGB: Hashable, Codable {
         var red: CGFloat
         var green: CGFloat
         var blue: CGFloat
         var alpha: CGFloat
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
    
    
    static var spruceBrown: UIColor = UIColor(red: 83/255, green: 52/255, blue: 0, alpha: 1)
    static var darkBrown: UIColor = UIColor(red: 85/255, green: 37/255, blue: 0, alpha: 1)
    
    static var darkPurple: UIColor = UIColor(red: 89/255, green: 24/255, blue: 70/255, alpha: 1)
    static var lavender: UIColor = UIColor(red: 230/255, green: 230/255, blue: 250/255, alpha: 1)
    static var violet: UIColor = UIColor(red: 238/255, green: 130/255, blue: 238/255, alpha: 1)
    static var mediumPurple: UIColor = UIColor(red: 147/255, green: 112/255, blue: 219/255, alpha: 1)
}
