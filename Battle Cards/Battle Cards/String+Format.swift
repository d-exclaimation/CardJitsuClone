//
//  String+Format.swift
//  Battle Cards
//
//  Created by Vincent on 10/24/20.
//

import Foundation

extension String {
    func capitalized() -> String {
        if self.count < 1 { return self }
        var newValue = ""
        self.map { String($0) }.forEach { newValue += newValue.count == 0 ? $0.uppercased() : $0 }
        return newValue
    }
}

extension Array where Element == String {
    var compressed: String {
        var newValue = ""
        self.forEach { newValue += $0 }
        return newValue
    }
}
