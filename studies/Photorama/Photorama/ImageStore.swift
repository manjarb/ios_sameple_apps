//
//  ImageStore.swift
//  Homepwner
//
//  Created by Varis Darasirikul on 4/20/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache()
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key)
        
        // Create full URL for image
        let imageURL = imageURLForKey(key)
        
        // Turn image into JPEG data
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            
            // Write it to full URL
            data.writeToURL(imageURL, atomically: true)
        }
        
    }
    
    func imageForKey(key: String) -> UIImage? {
        //return cache.objectForKey(key) as? UIImage
        
        if let existingImage = cache.objectForKey(key) as? UIImage {
            return existingImage
        }
        
        let imageURL = imageURLForKey(key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path!) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key)
        
        return imageFromDisk
        
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObjectForKey(key)
        
        let imageURL = imageURLForKey(key)
        //NSFileManager.defaultManager().removeItemAtURL(imageURL)
        do {
            try NSFileManager.defaultManager().removeItemAtURL(imageURL)
        }
        catch let deleteError{
            print("ERROR removing the image from disk: \(deleteError)")
        }
        
    }
    
    func imageURLForKey(key: String) -> NSURL {
        
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.URLByAppendingPathComponent(key)
        
    }
    
    

    
}
