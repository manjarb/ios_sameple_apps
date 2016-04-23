//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Varis Darasirikul on 4/22/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController,UICollectionViewDelegate {
    
    //@IBOutlet var imageView: UIImageView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchRecentPhotos() {
            (PhotosResult) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                switch PhotosResult {
                case let .Success(photos):
                    print("SuccessFully found \(photos.count) recent photos.")
                    
    //                if let firstPhoto = photos.first {
    //                    self.store.fetchImageForPhoto(firstPhoto) {
    //                        (imageResult) -> Void in
    //                        
    //                        switch imageResult {
    //                        case let .Success(image):
    //                            //self.imageView.image = image
    //                            
    //                            NSOperationQueue.mainQueue().addOperationWithBlock {
    //                                //self.imageView.image = image
    //                                //print(image)
    //                            }
    //                            
    //                        case let .Failure(error):
    //                            print("Error downloading image: \(error)")
    //                        }
    //                    }
    //                }
                    
                    self.photoDataSource.photos = photos
                    
                case let .Failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error)")
                    
                }
                
                self.collectionView.reloadSections(NSIndexSet(index: 0))
                
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let photo = photoDataSource.photos[indexPath.row]
        
        // Download the image data, which could take some time     
        
        store.fetchImageForPhoto(photo) { (result) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                
                // The index path for the photo might have changed between the             
                // time the request started and finished, so find the most             
                // recent index path             
                // (Note: You will have an error on the next line; you will fix it soon)             
                
                let photoIndex = self.photoDataSource.photos.indexOf(photo)!
                let photoIndexPath = NSIndexPath(forRow: photoIndex, inSection: 0)
                
                // When the request finishes, only update the cell if it's still visible             
                
                if let cell = self.collectionView.cellForItemAtIndexPath(photoIndexPath)                                                          as? PhotoCollectionViewCell {
                    
                    cell.updateWithImage(photo.image)
                }
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPhoto" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems()?.first {
                
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let destinationVC = segue.destinationViewController as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
                
            }
        }
    }
    
}
