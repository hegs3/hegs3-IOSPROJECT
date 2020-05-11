//
//  TagStore.swift
//  TagPicture
//
//  Created by JURA on 2019. 9. 2..
//  Copyright © 2019년 jura. All rights reserved.
//

import Foundation

class TagStore {
    var tagAll = [Tag]()
    var lastAuth:Int!
    
    
    func createTag() -> Tag {
        var newTag = Tag(line: 0, subject: "0", auth: 0)
        if tagAll.isEmpty {
            let tag = Tag(line: 1, subject: "ChangeTagName", auth: 0)
            newTag = tag
        } else {
            let tag = Tag(line: (tagAll.last?.line)! + 1, subject: "ChangeTagName", auth: 0)
            newTag = tag
        }
        tagAll.append(newTag)
        return newTag
    }
    
    func removeTag(item: Tag) {
        if let index = tagAll.lastIndex(of: item){
            tagAll.remove(at: index)
        }
    }
    
    func moveTag(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            print("return")
            return
        }
        let moveItem = tagAll[fromIndex]
        tagAll.remove(at: fromIndex)
        tagAll.insert(moveItem, at: toIndex)
        var j = 0
        for _ in tagAll {
            tagAll[j].line = j + 1
            j += 1        }
    }
    
    
}

