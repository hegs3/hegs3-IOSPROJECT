//
//  AllDataModel.swift
//  FontFinder
//
//  Created by JURA on 2020/03/22.
//  Copyright © 2020 jura. All rights reserved.
//

import Foundation
import RealmSwift







struct AllDataModel {
    var name: String?
    var email: String?
    var uuid: String?
    
    var realm: Realm!
    var dataRealm: RealmDBModel!
    
    mutating func emailInputData (emailOpt: String?) {
        guard let email = emailOpt else {
            print("emailOpt x")
            return
        }
        self.email = email
        if (uuidDataUnwrappedGet() == "" ) {
            return
        }
        if (uuidDataUnwrappedGet().isEmpty ) {
            return
        }
    }
    
    mutating func nameInputData (nameOpt: String?) {
        guard let name = nameOpt else {
            print("nameOpt x")
            return
        }
        self.name = name
        
        
        if (uuidDataUnwrappedGet() == "" ) {
            return
        }
        if (uuidDataUnwrappedGet().isEmpty ) {
            return
        }
        dataRealm = RealmDBModel()
        print(dataRealm.email)
        print(dataRealm.name)
        dataRealm.email = emailDataUnwrappedGet()
        dataRealm.name = nameDataUnwrappedGet()
        
            try! realm.write ({
                realm.add(dataRealm, update: .modified)
            })
    }
    
    mutating func uuidInputData (uuidOpt: String?) {
        guard let uuid = uuidOpt else {
            print("uuidOpt x")
            return
        }
        self.uuid = uuid
    }
    func emailDataUnwrappedGet() -> String {
        guard let email = self.email else {
            print("Err: emailData is Empty x")
            return ""
        }
        return email
    }
    func nameDataUnwrappedGet() -> String {
        guard let name = self.name else {
            print("Err: nameData is Empty x")
            return ""
        }
        return name
    }
    func uuidDataUnwrappedGet() -> String {
        guard let uuid = self.uuid else {
            print("Err: uuidData is Empty x")
            return ""
        }
        return uuid
    }
}



        
//        do {
//            try realm.write ({
//                uiRealm.add(object, update: false)
//                print(" Photo stored.")
//            })
//        }catch let error {
//            print(error)
//        }
////        }
//        dataRealm.email = self.email!
//        try! realm.write {
////        dataRealm.email = self.email!
//        }
