//
//  Array+Identifiable.swift
//  Battle Cards
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import Foundation

// Extends the capabilities of Array
extension Array {
    var firstHalf: Array<Element> {
        self.indices.filter{ $0 < self.count / 2 }.map{ self[$0] }
    }
    var secondHalf: Array<Element> {
        self.indices.filter{ $0 >= self.count / 2 }.map{ self[$0] }
    }
}

//extension Array where Element == 
