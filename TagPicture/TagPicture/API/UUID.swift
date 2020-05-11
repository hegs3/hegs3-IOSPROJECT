//
//  UUID.swift
//  TagPicture
//
//  Created by JURA on 2019. 6. 15..
//  Copyright © 2019년 jura. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class UUID {
    
    private let UNIQUE_KEY = "mySuperDuperUniqueId"
    
    var uuid: String = ""
    
    func createUUID() -> String {
        let uniqueDeviceId: String? = KeychainWrapper.standard.string(forKey: UNIQUE_KEY)

        guard uniqueDeviceId != nil else {
            let uuid = generateUuid()
            let saveSuccessful: Bool = KeychainWrapper.standard.set(uuid, forKey: UNIQUE_KEY)
            if saveSuccessful {
                self.uuid = uuid
            } else {
                fatalError("Unable to save uuid")
            }
            return self.uuid
        }
            self.uuid = (uniqueDeviceId)!
        return self.uuid
        
    }
    
    private func generateUuid() -> String {
        let uuidRef: CFUUID = CFUUIDCreate(nil)
        let uuidStringRef: CFString = CFUUIDCreateString(nil, uuidRef)
        return uuidStringRef as String
    }
}

