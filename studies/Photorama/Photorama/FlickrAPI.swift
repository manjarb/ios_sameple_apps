//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Varis Darasirikul on 4/22/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

import Foundation
import CoreData

enum Method: String {
    case RecentPhotos = "flickr.photos.getRecent"
}

enum PhotosResult {
    case Success([Photo])
    case Failure(ErrorType)
}

enum FlickrError: ErrorType {
    case InvalidJSONData
}

struct FlickrAPI {
    
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let APIKey = "7a9428a78d54786f7f8aa2fe569b302a"
    
    // secret b3a5b519179fd653
    
    private static let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    
    }()
    
    private static func photoFromJSONObject(json: [String : AnyObject],
                                            inContext context: NSManagedObjectContext) -> Photo? {
        guard let
            photoID = json["id"] as? String,
            title = json["title"] as? String,
            dateString = json["datetaken"] as? String,
            photoURLString = json["url_h"] as? String,
            url = NSURL(string: photoURLString),
            dateTaken = dateFormatter.dateFromString(dateString) else {
                
            // Don't Have enough information to construct a Photo
            return nil
        }
        
        let fetchRequest = NSFetchRequest(entityName: "Photo")
        
        let predicate = NSPredicate(format: "photoID == \(photoID)")
        fetchRequest.predicate = predicate
        
        var fetchedPhotos: [Photo]!
        context.performBlockAndWait() {
            fetchedPhotos = try! context.executeFetchRequest(fetchRequest) as! [Photo]
        }
        if fetchedPhotos.count > 0 {
            return fetchedPhotos.first
        }
        
        //return Photo(title: title, photoID: photoID, remoteURL: url, dateTaken: dateTaken)
        
        var photo: Photo!
        context.performBlockAndWait() {
            photo = NSEntityDescription.insertNewObjectForEntityForName("Photo",
                inManagedObjectContext: context) as! Photo
            photo.title = title
            photo.photoID = photoID
            photo.remoteURL = url
            photo.dateTaken = dateTaken
        }
        
        return photo
        
        
    }
    
    private static func flickrURL(method method: Method,
                                  parameters: [String:String]?) -> NSURL {
        //return NSURL()
        
        let components = NSURLComponents(string: baseURLString)!
        
        var queryItems = [NSURLQueryItem]()
        
        let baseParams = [
            "method" : method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": APIKey
        ]
        
        for (key,value) in baseParams {
            let item = NSURLQueryItem(name: key, value:  value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key,value) in additionalParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        
        return components.URL!
        
    }
    
    static func recentPhotosURL() -> NSURL {
        return flickrURL(method: .RecentPhotos, parameters: ["extras": "url_h,date_taken"])
    }
    
    static func photosFromJSONData(data: NSData,
                                   inContext context: NSManagedObjectContext) -> PhotosResult {
        do {
            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            
            guard let jsonDictionary = jsonObject as? [NSObject:AnyObject],
            photos = jsonDictionary["photos"] as? [String:AnyObject],
                photosArray = photos["photo"] as? [[String:AnyObject]] else {
                    
                    // THE Json structure doesn't match our expectations
                    return .Failure(FlickrError.InvalidJSONData)
            }
            
            
            var finalPhotos = [Photo]()
            
            for photoJSON in photosArray {
                if let photo = photoFromJSONObject(photoJSON, inContext: context) {
                    finalPhotos.append(photo)
                }
            }
            
            if finalPhotos.count == 0 && photosArray.count > 0 {
                // We weren't able to parse any of the photos
                // Maybe the JSON format for photos has changed
                return .Failure(FlickrError.InvalidJSONData)
            }
            
            return .Success(finalPhotos)
        }
        catch let error {
            return .Failure(error)
        }
    }
    
}





