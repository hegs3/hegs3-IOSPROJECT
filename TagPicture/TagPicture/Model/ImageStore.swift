//
//  ImageStore.swift
//  JrMemo
//
//  Created by JURA on 2019. 1. 17..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class ImageStore {
    // MARK: cache property
    let cache: NSCache<AnyObject, AnyObject>!
    
    init() {
        self.cache = NSCache<AnyObject, AnyObject>()
    }
    
    
    // MARK: ImageKeyURL
    func imageURLForKey(key: String) -> URL {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
    // MARK: ImageKeySet
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as AnyObject)
        let imageURL = imageURLForKey(key: key)
        if let  data = image.jpegData(compressionQuality: 0.5) {
            do {
                try data.write(to: imageURL, options: Data.WritingOptions.atomic)
            } catch {
                print("ERROR")
            }
        }
    }
    
    // MARK: ImageKeyGet
    func imageForKey(key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as AnyObject) as? UIImage {
            return existingImage
        }
        let imageURL = imageURLForKey(key: key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path) else {
            return UIImage()
        }
        cache.setObject(imageFromDisk, forKey: key as AnyObject)
        
        return imageFromDisk
    }
    
    // MARK; ImageDelete
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as AnyObject)
        let imageURL = imageURLForKey(key: key)
        do {
            try FileManager.default.removeItem(at: imageURL)
            print("SS")
        } catch let deleteError {
            print("Error removeing the image form disk: \(deleteError)")
        }
    }
}
