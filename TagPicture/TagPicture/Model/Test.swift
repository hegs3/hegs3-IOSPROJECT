//
//  Test.swift
//  TagPicture
//
//  Created by JURA on 2019. 9. 17..
//  Copyright © 2019년 jura. All rights reserved.
//

import Foundation

struct Test: Decodable {
    let line: String
    let subject: String
    let auth: String
    
    private enum CodingKeys: String, CodingKey {
        case line
        case subject
        case auth
    }
}
