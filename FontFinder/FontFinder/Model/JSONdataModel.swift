//
//  JSONdataModel.swift
//  FontFinder
//
//  Created by JURA on 2020/03/18.
//  Copyright © 2020 jura. All rights reserved.
//

import Foundation


struct InitialData: Codable {
    var email: String?
    var name: String?
    var uuid: String?
    enum CodingKeys: String, CodingKey {
        case email, name, uuid
    }
    
    init(decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)

        //값이나 키가 없는경우 예외처리, string외 타입의 경우는 php 및 mysql 에서 처리
        email = try value.decode(String.self, forKey: .email)
        name = try value.decode(String.self, forKey: .name)
        uuid = try value.decode(String.self, forKey: .uuid)
        email = try value.decodeIfPresent(String.self, forKey: .email)
        name = try value.decodeIfPresent(String.self, forKey: .name)
        uuid = try value.decodeIfPresent(String.self, forKey: .uuid)
    }
    init (email: String, uuid: String, name: String) throws {
        self.email = email
        self.name = name
        self.uuid = uuid
        
    }
}
