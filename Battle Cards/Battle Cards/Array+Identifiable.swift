//
//  Array+Identifiable.swift
//  Battle Cards
//
//  Created by Vincent on 9/24/20.
//

import Foundation

// Extends the capabilities of Array if the element inside is identifiable
extension Array where Element: Identifiable {
    
    // Find the index of the first element using the id
    func firstIndexOf(element: Element) -> Int? {
        
        // Basic loop through the array
        for index in 0..<self.count {
            
            // If current pointed item has the same index as the one which is asked, return it
            if self[index].id == element.id {
                return index
            }
        }
        
        // find none return nil
        return nil
    }
}
