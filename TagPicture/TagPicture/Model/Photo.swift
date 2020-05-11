//
//  Photo.swift
//  TagPicture
//
//  Created by JURA on 2019. 4. 29..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class Photo {
    var title: String
    var remoteURL: URL
    var photoID: String
    var cntDate: Date
    var width: Any?
    var height: Any?
    var photoSize: String
    var image: UIImage?
    var auth: Int?
    
    var dateTaken: String
    init(title: String, photoID: String, remoteURL: URL, cntDate: Date, width: Any, height: Any, photoSize: String, auth: Int) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.cntDate = cntDate
        self.width = width
        self.height = height
        self.photoSize = photoSize
        self.auth = auth
        
        let heightS: String
        let heightI: Int
        let widthS: String
        let widthI: Int
        let realHeight: String
        let realWidth: String
        
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        dateTaken = date.string(from: cntDate)
        
        if photoSize.isEmpty {
            if let ht = self.height as? String {
                heightS = ht
            } else {
                heightS = ""
            }
            if let ht = self.height as? Int {
                heightI = ht
                
            } else {
                heightI = 0
            }
            if let wd = self.width as? String {
                widthS = wd
            } else {
                widthS = ""
            }
            if let wd = self.width as? Int {
                widthI = wd
                
            } else {
                widthI = 0
            }
            if (heightS == "") {
                realHeight = String(heightI)
            } else {
                realHeight = heightS
            }
            if (widthS == "") {
                realWidth = String(widthI)
            } else{
                realWidth = widthS
            }
            self.photoSize = "\(realHeight)x\(realWidth)"
        }
        
        
     
    }
}


extension Photo: Equatable {
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.photoID == rhs.photoID
    }
}
