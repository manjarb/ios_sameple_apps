//
//  PhotoStore.swift
//  Photorama
//
//  Created by Varis Darasirikul on 4/22/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

//import Foundation
import UIKit

enum ImageResult {
    case Success(UIImage)
    case Failure(ErrorType)
}

enum PhotoError: ErrorType {
    case ImageCreationError
}

class PhotoStore {
    
    let coreDataStack = CoreDataStack(modelName: "Photorama")
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func fetchRecentPhotos(completion completion: (PhotosResult) -> Void) {
        let url = FlickrAPI.recentPhotosURL()
        let request = NSURLRequest(URL: url)
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
//            if let jsonData = data {
////                if let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) {
////                    print(jsonString)
////                }
//                
//                do {
//                    let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
//                    print(jsonObject)
//                }
//                catch let error {
//                    print("Error creating Json object: \(error)")
//                }
//                
//            } else
//            if let requestError = error {
//                print("Error fetching recent photos: \(requestError)")
//            } else {
//                print("Un expected error request")
//            }
            
            let result = self.processRecentPhotosRequest(data: data, error: error)
            completion(result)
            
        }
        
        task.resume()
        
    }
    
    func processRecentPhotosRequest(data data: NSData?, error: NSError?) -> PhotosResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        
        return FlickrAPI.photosFromJSONData(jsonData,inContext: self.coreDataStack.mainQueueContext)
    }
    
    func fetchImageForPhoto(photo: Photo, completion: (ImageResult) -> Void) {
        
        if let image = photo.image {
            completion(.Success(image))
            return
        }
        
        let photoURL = photo.remoteURL
        let request = NSURLRequest(URL: photoURL)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            var result = self.processImageRequest(data: data, error: error)
            
            if case let .Success(image) = result {
                
                do {
                    try self.coreDataStack.saveChanges()
                }
                catch let error {
                    result = .Failure(error)
                }
                
                //photo.image = image
            }
            
            completion(result)
            
        }
        task.resume()
    }
    
    func processImageRequest(data data: NSData?, error: NSError?) -> ImageResult {
        guard let
            imageData = data,
            image = UIImage(data: imageData) else {
                // Couldn't create an image             
                if data == nil {
                    return .Failure(error!)
                }
                else {
                    return .Failure(PhotoError.ImageCreationError)
                }
        }
        
        return .Success(image)
    }
}