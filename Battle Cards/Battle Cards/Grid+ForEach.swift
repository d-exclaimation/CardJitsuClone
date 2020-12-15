//
//  Grid.swift
//  Memorize
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import SwiftUI

struct Grid<Item, ID, ItemView>: View where ID: Hashable, ItemView:  View {
    private var items: [Item]
    private var id: KeyPath<Item, ID>
    private var someItem: (Item) -> ItemView
    
    
    init(_ items: [Item], id: KeyPath<Item,ID>, someItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.id = id
        // An escaping function, saved to be reused
        self.someItem = someItem
    }
    
    var body: some View {
        
        // Given the geometry
        GeometryReader { geometry in
            // Created a for each loop for each item in identifiable item
            ForEach(items, id: id) { item in
                body(for: item, in: GridLayout(itemCount: items.count, in: geometry.size)) // Create a body with the item, and the layout
            }
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        
        // Set item view with it's modifiers using the parameters given
        someItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: items.firstIndex(where: { item[keyPath: id] == $0[keyPath: id] })!))
    }

}

extension Grid where Item: Identifiable, ID == Item.ID {
    init(_ items: [Item], someItem: @escaping (Item) -> ItemView) {
        self.init(items, id: \Item.id, someItem: someItem)
    }
}



