//
//  test.swift
//  FontFinder
//
//  Created by JURA on 2020/03/17.
//  Copyright © 2020 jura. All rights reserved.
//

import Foundation

//http://minsone.github.io/programming/swift-codable-and-exceptions-extension
//키와 밸류가 없는상황도 대비를 해야한다.(특정key,value가 없는경우)
//값이 null인경우.
//JSON이 같은 타입의 값을 가진 배열인 경우
//JSON이 지정되지 않은 타입인 경우

//컨트롤러 실행

//let sample1Data = """
//{
//    "a": "aa",
//    "b": "bb"
//}
//""".data(using: .utf8)!
//let sample1 = try! JSONDecoder().decode(Sample1.self, from: sample1Data)
//print(sample1) // Sample1(a: "aa", b: "bb")
//
//let sample2Data = """
//{
//    "a": "aa",
//    "b": "bb",
//    "list": [{"a": "aa"}]
//}
//""".data(using: .utf8)!
//let sample2 = try! JSONDecoder().decode(Sample2.self, from: sample2Data)
//print(sample2) // Sample1(a: "aa", b: "bb")
//
//



struct Sample1: Codable {//Json model struct
    var a: String?//codingKeys를 정의하지 않는경우는 키값과 동일한 타입명을 지정해야한다
    var y: String?
    enum CodingKeys: String, CodingKey {// 만약 타입명과 키값이 다르면 CodingKey정의를 해야함
        case a, y = "b"
    }
    
    //특정key가 없는경우
//    * before
//    {
//        "a": "aa",
//        "b": "bb"
//    }
//
//    * after
//    {
//        "a": "aa"
//    } //같은 형태로 키값이 존재하지 않은상태로 넘어올 수있음
    //특정value가 없는경우
//    let sample1Data = """
//    {
//        "a": null
//    }
    init(from decoder: Decoder) throws {//예외처리
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //특정key가 없는경우
        a = try values.decode(String.self, forKey: .a)
//        a = (try? values.decode(String.self, forKey: .a)) ?? ""
        y = try values.decode(String.self, forKey: .y)
        
        //특정value가 없는경우
        a = try values.decodeIfPresent(String.self, forKey: .a)
        y = try values.decodeIfPresent(String.self, forKey: .y)
    }
}


struct Sample2: Codable {
    var a: String?
    var b: String?
    var list: [Sample3]
    
    init(from decoder:Decoder) throws {
//        JSON이 같은 타입의 값을 가진 배열인 경우
//        ["a", "b", "c"]
        list = try decoder.singleValueContainer().decode([Sample3].self)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        a = try values.decodeIfPresent(String.self, forKey: .a)
        b = try values.decodeIfPresent(String.self, forKey: .b)
    }
}

struct Sample3: Codable {
    var a: String
}


//JSON이 지정되지 않은 타입인 경우
//["a", 1, 10.0, true, "b"]
struct Sample4: Codable {
    var str: String
    var int: Int
    var float: Float
    var bool: Bool
    
    init(from decoder: Decoder) throws {
        var unkeyedContainer = try decoder.unkeyedContainer()
        str = try unkeyedContainer.decode(String.self)
        int = try unkeyedContainer.decode(Int.self)
        float = try unkeyedContainer.decode(Float.self)
        bool = try unkeyedContainer.decode(Bool.self)
    }
}




extension KeyedDecodingContainer {
    func decode<T>(_ key: KeyedDecodingContainer.Key) throws -> T where T: Decodable {
        return try decode(T.self, forKey: key)
    }
    func decodeArray<T>(_ key: KeyedDecodingContainer.Key) throws -> [T] where T: Decodable {
        return try decode([T].self, forKey: key)
    }
    
    func decodeIfPresent<T>(_ key: KeyedDecodingContainer.Key) throws -> T? where T: Decodable {
        return try decodeIfPresent(T.self, forKey: key)
    }

    subscript<T>(key: Key) -> T where T: Decodable {
        return try! decode(T.self, forKey: key)
    }
}
extension UnkeyedDecodingContainer {
    mutating func decode<T>() throws -> T where T: Decodable {
        return try decode(T.self)
    }
    
    mutating func decodeArray<T>() throws -> [T] where T: Decodable {
        var list: [T] = []
        while !isAtEnd {
            list.append(try decode(T.self))
        }
        return list
    }
}

extension SingleValueDecodingContainer {
    mutating func decode<T>() throws -> [T] where T: Decodable {
        return try decode([T].self)
    }
}
