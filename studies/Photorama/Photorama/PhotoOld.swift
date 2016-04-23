//
//  Photo.swift
//  Photorama
//
//  Created by Varis Darasirikul on 4/22/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

//import Foundation
import UIKit

class Photo {
    
    let title: String
    let remoteURL: NSURL
    let photoID: String
    let dateTaken: NSDate
    var image: UIImage?
    
    init(title: String,photoID: String, remoteURL: NSURL, dateTaken: NSDate){
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
    
}

extension Photo: Equatable {}

func == (Ihs: Photo, rhs: Photo) -> Bool {
    
    // Two Photos are the same if they have the same photoID
    return Ihs.photoID == rhs.photoID
    
}