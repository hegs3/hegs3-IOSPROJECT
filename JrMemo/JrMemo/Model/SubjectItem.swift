//
//  SubjectItem.swift
//  JrMemo
//
//  Created by JURA on 2019. 1. 8..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class SubjectItem: NSObject, NSCoding {
    // MARK: property
    var subjectTitle: String?
    var contentDetail: String?
    var subjectDate: String?
    var imageKey: String
    var isEmptyImage: Bool
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    
    // MARK: init())
    init(subjectTitle: String?, contentDetail: String?, subjectDate: String?) {
        let date = Date()
        self.subjectTitle = subjectTitle
        self.contentDetail = contentDetail
        self.subjectDate = dateFormatter.string(from: date)
        
        self.imageKey = UUID().uuidString
        self.isEmptyImage = true
        super.init()
    }
    convenience override init() {
        self.init(subjectTitle: "Not Subject", contentDetail: "", subjectDate: "")
    }
    
    
    // MARK: Archive, UnArchive
    func encode(with aCoder: NSCoder) {
        aCoder.encode(subjectTitle, forKey: "subjectTitle")
        aCoder.encode(subjectDate, forKey: "subjectDate")
        aCoder.encode(contentDetail, forKey: "contentDetil")
        aCoder.encode(imageKey, forKey: "imageKey")
        aCoder.encode(isEmptyImage, forKey: "isEmptyImage")
        
    }
    required init(coder aDecoder: NSCoder) {
        self.subjectTitle = aDecoder.decodeObject(forKey: "subjectTitle") as? String
        self.contentDetail = aDecoder.decodeObject(forKey: "contentDetil") as? String
        self.subjectDate = aDecoder.decodeObject(forKey: "subjectDate") as? String
        self.imageKey = aDecoder.decodeObject(forKey: "imageKey") as! String
        self.isEmptyImage = aDecoder.decodeBool(forKey: "isEmptyImage")
        super.init()
    }
}
