//
//  GridLayout.swift
//  Memorize
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import Foundation
import SwiftUI

struct GridLayout {
    private(set) var size: CGSize
    private(set) var rowCount: Int = 0
    private(set) var columnCount: Int = 0
    
    init(itemCount: Int, nearAspectRatio desiredAspectRatio: Double = 1, in size: CGSize) {
        self.size = size
        
        // if our size is zero width or height or the itemCount is not > 0
        // then we have no work to do (because our rowCount & columnCount will be zero)
        guard size.width != 0, size.height != 0, itemCount > 0 else { return }
        
        // find the bestLayout
        // i.e., one which results in cells whose aspectRatio
        // has the smallestVariance from desiredAspectRatio
        // not necessarily most optimal code to do this, but easy to follow (hopefully)
        
        // Set up first current best layout is just 1 row and itemCount columns
        var bestLayout: (rowCount: Int, columnCount: Int) = (1, itemCount)
        
        // Set an optional variable that is going to be a double for the smallest variance
        var smallestVariance: Double?
        
        // Get the accurate aspect ratio
        let sizeAspectRatio = abs(Double(size.width/size.height))
        
        // Loop through to find best aspect ratio
        for rows in 1...itemCount {
            
            // For the current row, column will be itemCount / rows + 1 for by any extra left or 0 if it doesn't have a remainder
            let columns = (itemCount / rows) + (itemCount % rows > 0 ? 1 : 0)
            
            // If the multiplication of column and row - 1 is less than itemCount, removing the bad uneven grid
            if (rows - 1) * columns < itemCount {
                
                // Get the aspect ratio of each section
                let itemAspectRatio = sizeAspectRatio * (Double(rows)/Double(columns))
                
                // Get the difference of section aspect ratio and desired one
                let variance = abs(itemAspectRatio - desiredAspectRatio)
                
                // if there is no smallest variant or the current one is smaller than the smallest
                if smallestVariance == nil || variance < smallestVariance! {
                    
                    // Set the new smallest variance
                    smallestVariance = variance
                    
                    // Change the layout row and column
                    bestLayout = (rowCount: rows, columnCount: columns)
                }
            }
        }
        
        // Set the variables after the rezising
        rowCount = bestLayout.rowCount
        columnCount = bestLayout.columnCount
    }
    
    var itemSize: CGSize {
        // Return a default zero for empty grid
        if rowCount == 0 || columnCount == 0 {
            return CGSize.zero
            
        // Otherwise, return the CGSize adjusted with the amount of column and row
        } else {
            return CGSize(
                width: size.width / CGFloat(columnCount),
                height: size.height / CGFloat(rowCount)
            )
        }
    }
    
    func location(ofItemAt index: Int) -> CGPoint {
        
        // Empty grid, return zero
        if rowCount == 0 || columnCount == 0 {
            return CGPoint.zero
            
        // Otherwise, return CGPoint with the given index adjusted to the width and height
        } else {
            return CGPoint(
                x: (CGFloat(index % columnCount) + 0.5) * itemSize.width,
                y: (CGFloat(index / columnCount) + 0.5) * itemSize.height
            )
        }
    }
}
