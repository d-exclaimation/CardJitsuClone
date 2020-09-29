//
//  Grid.swift
//  Memorize
//
//  Created by Vincent on 9/18/20.
//  Copyright © 2020 Vincent. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView:  View {
    private var items: [Item]
    private var someItem: (Item) -> ItemView
    
    // Initialize using any Item array, and function
    init(_ items: [Item], someItem: @escaping (Item) -> ItemView) {
        self.items = items
        
        // An escaping function, saved to be reused
        self.someItem = someItem
    }
    
    var body: some View {
        
        // Given the geometry
        GeometryReader { geometry in
            // Created a for each loop for each item in identifiable item
            ForEach(items) { item in
                body(for: item, in: GridLayout(itemCount: items.count, in: geometry.size)) // Create a body with the item, and the layout
            }
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        
        // Set item view with it's modifiers using the parameters given
        someItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: items.firstIndexOf(element: item)!))
    }

}



