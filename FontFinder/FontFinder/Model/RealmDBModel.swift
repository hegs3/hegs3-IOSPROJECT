//
//  RealmDBModel.swift
//  FontFinder
//
//  Created by JURA on 2020/03/18.
//  Copyright © 2020 jura. All rights reserved.
//

import Foundation
import RealmSwift

//출처: https://hyongdoc.tistory.com/336 [DevLogs & Everything]
class RealmDBModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var uuid = UUID().createUuid()
    
    
    override static func primaryKey() -> String? {
      return "uuid"
    }
}



//let dateSelected = DateRealm()
//dateSelected.year = year
//dateSelected.month = month
//dateSelected.day = day
//
//// Realm 가져오기
//let realm = try! Realm()
//
//// Realm 에 저장하기
//try! realm.write {
//    realm.add(dateSelected)
//}

//불러오기
//let realm = try! Realm()
//let savedDates = realm.objects(DateRealm.self)
//print(savedDates) // => 0 because no dogs have been added to the Realm yet

//불러온데이터 정렬 및 필터
//let realm = try! Realm()
//let savedDates = realm.objects(DateRealm.self)
//// day 기준으로 sorting
//print(savedDates.sorted(byKeyPath: "day", ascending: true))
//// day가 07인 경우만
//print(savedDates.filter("day == '07'"))


//저장된데이터 삭제
//let realm = try! Realm()
//let dateSelected = DateRealm()
//dateSelected.year = year
//dateSelected.month = month
//dateSelected.day = day
//
////삭제하는 방법
//do{
//    try realm.write{
//        let predicate = NSPredicate(format: "year = %@ AND month = %@ AND day = %@", year, month, day)
//        realm.delete(realm.objects(DateRealm.self).filter(predicate))
//    }
//} catch{ print("\(error)") }
//
//
//실행하신 후, 아래 코드를 실행했을 때 나오는 폴더에 있는 realm파일을 열면, 저장된 데이터를 조회/편집할 수 있습니다.
//
//print(Realm.Configuration.defaultConfiguration.fileURL!)
//
//
//



