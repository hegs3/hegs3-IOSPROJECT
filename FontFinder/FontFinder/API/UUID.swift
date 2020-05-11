//
//  UUID.swift
//  FontFinder
//
//  Created by JURA on 2020/03/18.
//  Copyright © 2020 jura. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper


// TODO: - 추가: uuid가져오기 성공했을때 데이터 처리
// TODO: - 추가: 실패했을때 어떻게 할건지(ex 에러 출력 후 앱종료할지 재시작 할지 재시작할경우 1번의 재시작 그래도 못받아오면 notification  확인 취소 후 개발자에게 에러 내용 송출)

class UUID {
    private let UNIQUE_KEY = "FontFinderSuperUniqueId"
    
    @discardableResult
    func createUuid() -> String {
        let uniqueDeviceId: String? = KeychainWrapper.standard.string(forKey: UNIQUE_KEY)
        guard uniqueDeviceId != nil else {
            
            let uuid = generateUuid()
            
            //데이터 저장 성공 유무
            let saveSuccessful: Bool = KeychainWrapper.standard.set(uuid, forKey: UNIQUE_KEY)
            //uuid 데이터 가져올 떄
//            let retrievedString: String? = KeychainWrapper.standard.string(forKey: "myKey")
            //uuid 저장돼있는 데이터 삭제
//            let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "myKey")
            
            if saveSuccessful {//db에 저장 시도
                    
            } else {
                fatalError("Unable to save uuid")
            }
            return uniqueDeviceId ?? ""
        }
//               uuidValue.text = uniqueDeviceId!
        return uniqueDeviceId ?? ""
    }
       
    

    private func generateUuid() -> String {
        let uuidRef: CFUUID = CFUUIDCreate(nil)
        let uuidStringRef: CFString = CFUUIDCreateString(nil, uuidRef)
        return uuidStringRef as String
    }

}
