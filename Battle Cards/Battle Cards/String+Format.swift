//
//  String+Format.swift
//  Battle Cards
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import Foundation

extension String {
    func capitalized() -> String {
        if count < 1 { return self }
        return prefix(1).uppercased() + dropFirst()
    }
}

extension Array where Element == String {
    var compressed: String {
        var newValue = ""
        self.forEach { newValue += $0 }
        return newValue
    }
}
