//
//  FolderViewDataSource.swift
//  JrMemo
//
//  Created by JURA on 2019. 1. 1..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class  FolderViewDataSource: UITableViewDataSource {
    // MARK: TableDataSource
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderItemStore.folderAllItems.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: folderCellId, for: indexPath) as! FolderCell
        let item = folderItemStore.folderAllItems[indexPath.row]
        cell.folderNameLabel.text = item.folderName
        return cell
    }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = folderItemStore.folderAllItems[indexPath.row]
        if editingStyle == .delete {
            let title = "Delete \(item.folderName!) folder?"
            let message = "Are you sure???"
            let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            let delete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: {
                (action) -> Void in
                self.folderItemStore.removeFolderItem(item: item)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            })
            ac.addAction(cancel)
            ac.addAction(delete)
            present(ac, animated: true, completion: nil)
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing == true {
            
            let item = folderItemStore.folderAllItems[indexPath.row]
            let title = "Folder name!"
            let message = "Input new folder name."
            let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let confirm = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default) { (action) in
                let cell = tableView.dequeueReusableCell(withIdentifier: self.folderCellId, for: indexPath) as! FolderCell
                item.folderName = (ac.textFields?[0].text)!
                if item.folderName == ""{
                    item.folderName = "폴더이름변경"
                }
                cell.folderNameLabel.text = item.folderName
                
                tableView.reloadData()
            }
            
            ac.addAction(confirm)
            ac.addTextField { (textField) in
                textField.placeholder = item.folderName
                
            }
            self.present(ac, animated: true, completion: nil)
        }
    }
     func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        folderItemStore.moveFolderItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
