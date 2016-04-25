//
//  Photo.swift
//  Photorama
//
//  Created by Varis Darasirikul on 4/24/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

//import Foundation
import UIKit
import CoreData


class Photo: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    var image: UIImage?
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        // Give the properties their initial values
        title = ""
        photoID = ""
        remoteURL = NSURL()
        photoKey = NSUUID().UUIDString
        dateTaken = NSDate()
    }
    
    func addTagObject(tag: NSManagedObject) {
        
        let currentTags = mutableSetValueForKey("tags")
        currentTags.addObject(tag)
    
    }
    
    func removeTagObject(tag: NSManagedObject) {
        
        let currentTags = mutableSetValueForKey("tags")
        currentTags.removeObject(tag)
    }
    
    

}
