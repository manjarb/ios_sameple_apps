//
//  ItemStore.swift
//  Homepwner
//
//  Created by Varis Darasirikul on 4/7/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
//    init(){
//        for _ in 0..<5 {
//            createItem()
//        }
//    }
    
    
    func createItem() -> Item {
        
        let newItem = Item(random: true)
        print ("New item")
        print (newItem)
        allItems.append(newItem)
        
        return newItem
        
    }
    
    func removeItem(item: Item){
        if let index = allItems.indexOf(item){
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        // Remove item from array
        allItems.removeAtIndex(fromIndex)
        
        // Insert item in array at new location
        allItems.insert(movedItem, atIndex: toIndex)
        
    }
}


