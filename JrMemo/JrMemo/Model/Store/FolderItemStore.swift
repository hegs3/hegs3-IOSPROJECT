//
//  FolderItemStore.swift
//  JrMemo
//
//  Created by JURA on 2018. 12. 30..
//  Copyright © 2018년 jura. All rights reserved.


import UIKit

class FolderItemStore {
    // MARK: property
    var folderAllItems = [FolderItem]()
    // MARK: File URL(archive, unarchive) property
    let folderItemArchiveURL: URL = {
       let documentDirectories = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("folderItems.archive")
    }()
    
    
    // MARK: table Row function(행 생성, 제거, 이동)
    func createFolderItem() -> FolderItem {
        let newFolderItem = FolderItem(folderName: "ChangeFolderName",subjectObjects: SubjectItemStore.init().subjectAllItems)
        folderAllItems.append(newFolderItem)
        
        return newFolderItem
    }
    func removeFolderItem(item: FolderItem) {
        if let index = folderAllItems.lastIndex(of: item) {
            folderAllItems.remove(at: index)
        }
    }
    func moveFolderItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let moveItem = folderAllItems[fromIndex]
        folderAllItems.remove(at: fromIndex)
        folderAllItems.insert(moveItem, at: toIndex)
        print("\(fromIndex) - \(toIndex)")
    }
    
    
    // MARK: NSKeyedArchiver, NSKeyedUnarchiver
    func saveChanges() -> Bool {
        return NSKeyedArchiver.archiveRootObject(folderAllItems, toFile: folderItemArchiveURL.path)
    }
    init() {
        if let  archivedFolderItems = NSKeyedUnarchiver.unarchiveObject(withFile: folderItemArchiveURL.path) as? [FolderItem] {
            folderAllItems += archivedFolderItems
        }
    }
}


