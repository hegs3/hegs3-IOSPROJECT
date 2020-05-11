//
//  FolderItem.swift
//  JrMemo
//
//  Created by JURA on 2018. 12. 30..
//  Copyright © 2018년 jura. All rights reserved.
//

// Type Method - throwing method

import UIKit

class FolderItem:NSObject, NSCoding {
    // MARK: property
    var folderName: String?
    var subjectObjects: [SubjectItem]?
    
    
    // MARK: init
    init(folderName: String, subjectObjects: [SubjectItem]) {
        self.folderName = folderName
        self.subjectObjects = subjectObjects
        super.init()
    }
    
    
    // MARK: Archive, UnArchive`
    func encode(with aCoder:NSCoder) {
        aCoder.encode(folderName, forKey: "folderName")
        aCoder.encode(subjectObjects, forKey: "subjectObject")
    }
    required init(coder aDecoder: NSCoder) {
        self.folderName = aDecoder.decodeObject(forKey: "folderName") as? String
        self.subjectObjects = aDecoder.decodeObject(forKey: "subjectObject") as? [SubjectItem]
        super.init()
    }
}
