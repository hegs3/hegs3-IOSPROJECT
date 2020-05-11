//
//  SubjectItemStore.swift
//  JrMemo
//
//  Created by JURA on 2019. 1. 8..
//  Copyright © 2019년 jura. All rights reserved.
//
import UIKit

class SubjectItemStore {
    // MARK: property
    var folderItem: FolderItem!
    var subjectAllItems = [SubjectItem]()
    
    
    // MARK: File URL(archive, unarchive) property
    let subjectItemArchiveURL : URL = {
        let documentDirectories = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("subjectItems.archive")
    }()
    
    
    // MARK: SubjectData Connect function
    func connect() { //값 대입
        guard let allItems = folderItem.subjectObjects else {
            return
        }
        subjectAllItems = allItems
    }
    func save() { //값 가져오기
        folderItem.subjectObjects = subjectAllItems
    }
    
    
    // MARK: table Row function(행 생성, 제거, 이동)
    func createSubjectItem() -> SubjectItem {
        let newSubjectItem = SubjectItem()
        subjectAllItems.append(newSubjectItem)
        
        return newSubjectItem
    }
    func removeSubjectItem(item: SubjectItem) {
        if let index = subjectAllItems.lastIndex(of: item) {
            subjectAllItems.remove(at: index)
        }
    }
    func moveSubjectItem(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let moveItem = subjectAllItems[fromIndex]
        subjectAllItems.remove(at: fromIndex)
        subjectAllItems.insert(moveItem, at: toIndex)
    }
    
    
    // MARK: NSKeyedArchiver, NSKeyedUnarchiver
        func saveChanges() -> Bool {
            return NSKeyedArchiver.archiveRootObject(subjectAllItems, toFile: subjectItemArchiveURL.path)
        }
        init() {
            if let archivedSubjectItems = NSKeyedUnarchiver.unarchiveObject(withFile: subjectItemArchiveURL.path) as? [SubjectItem] {
                subjectAllItems += archivedSubjectItems
            }
        }
}
