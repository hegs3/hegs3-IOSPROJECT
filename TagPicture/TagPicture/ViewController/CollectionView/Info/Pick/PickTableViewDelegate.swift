//
//  PickTableViewDelegate.swift
//  TagPicture
//
//  Created by JURA on 2019. 8. 26..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class PickTableViewDelegate: NSObject, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing == true {
//            let item = folderItemStore.folderAllItems[indexPath.row]
            let title = "Change Folder name"
            let message = "Input new folder name."
            let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            let confirm = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default) { (action) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "PickTableViewCell", for: indexPath) as! PickTableViewCell

                cell.pickLabel.text = "item.folderName"
                tableView.reloadData()
            }
            ac.addAction(cancel)
            ac.addAction(confirm)
//            ac.addTextField { (textField) in
//                textField.placeholder = "ChangeFolderName"
//                if item.folderName != "ChangeFolderName"{
//                    textField.text = item.folderName
//                }
                
//            }
//            present(ac, animated: true, completion: nil)
            print("1")
        } else {
//            performSegue(withIdentifier: "subjectSegue", sender: self)
            print("2")
        }
    }
}
