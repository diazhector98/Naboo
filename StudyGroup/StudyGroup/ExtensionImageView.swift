//
//  ExtensionImageView.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 12/01/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject,AnyObject>()

extension UIImageView{
    
    
    //Sets the image of the UIImageview using the url string and stores it in the imagecache
    //If the image was already obtained, simply get it from the cache
    //This to have a quicker experience if studying multiple times.
    
    func loadImageUsingCacheWithUrlString(urlString: String){
    
        self.image = nil
        
        //Check if the image is already in the cache
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
        
            print("Placing image to image view from cache")

            self.image = cachedImage
            return
        }
        
        //Otherwise...
        
        let url = URL(string: urlString)
        
        //Get the data of the image using a url session
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
            
                print("Error in extension 1")
                return
            
            }
            
            //Using dispatch, convert the data to an image and set it for the image view
            DispatchQueue.main.async(execute: { 
                
                if let downloadedImage = UIImage(data: data!) {
                
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    print("Placing image to image view")
                    
                    self.image = downloadedImage
                
                
                }
                
            })
            
            
        }.resume()
    
    }
    
    public func imageFromServerUrl(urlString: String){
    
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL) { (data, response, error) in
            
            if error != nil {
            
                print("Error in extension 2")

                return
            
            }
            
            DispatchQueue.main.async(execute: { 
                let image = UIImage(data: data!)
                self.image = image
            })
            
            
            
        }.resume()
    
    
    }

    


}
