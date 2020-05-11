//
//  Tag.swift
//  TagPicture
//
//  Created by JURA on 2019. 9. 2..
//  Copyright © 2019년 jura. All rights reserved.
//

import Foundation

class Tag {
    
    var line: Int
    var subject: String
    var auth: Int
    var photoAll: [Photo]
    init(line: Int, subject:String, auth: Int) {
        self.line = line
        self.subject =  subject
        self.auth = auth
        photoAll = []
    }
}

extension Tag: Equatable {
    static func ==(lhs: Tag, rhs: Tag) -> Bool {
        return lhs.subject == rhs.subject
    }
}
