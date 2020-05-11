//
//  SubjectTableViewDatasource.swift
//  JrMemo
//
//  Created by JURA on 2019. 1. 8..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class SubjectTableViewDatasource: NSObject, UITableViewDataSource,UITableViewDelegate{
    
    var control = UIControl()
    
    // MARK: property
    var subjectItemStore = SubjectItemStore()
    var tableViewp: UITableView!
    var imageStore: ImageStore!
    
    
    
    // MARK: DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectItemStore.subjectAllItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         tableViewp = tableView
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath) as! SubjectCell
        let item = subjectItemStore.subjectAllItems[indexPath.row]
        cell.subjectTitleLabel.text = item.subjectTitle
        cell.subjectDateLabel.text = item.subjectDate
        
        var cellAudioButton: UIButton!
        cellAudioButton = UIButton(type: .custom)
        
        cellAudioButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        cellAudioButton.addTarget(self, action: #selector(accessoryButtonDown(sender:)), for: .touchDown)
        

        cellAudioButton.setImage(UIImage(named: "acc.png"), for: .normal)
        cellAudioButton.contentMode = .scaleAspectFit
        cellAudioButton.tag = indexPath.row
        
        cell.accessoryView = cellAudioButton as UIView

        
        
        
        if subjectItemStore.subjectAllItems[indexPath.row].isEmptyImage {
            cell.accessoryView = nil
            cell.accessoryType = UITableViewCell.AccessoryType.none

        } else {
            cell.accessoryView = cellAudioButton

        }

        
        return cell
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            let item = subjectItemStore.subjectAllItems[indexPath.row]
            let title = "Delete \(String(item.subjectTitle!)) subject!"
            let message = "Are you sure?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            let delete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: {
                (action) -> Void in
                self.subjectItemStore.removeSubjectItem(item: item)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            })
            ac.addAction(cancel)
            ac.addAction(delete)
            UIApplication.shared.keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
       }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.subjectItemStore.moveSubjectItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
    var imagePopupView = (UINib(nibName: "ImagePopupView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! ImagePopupView)

    


    // MARK: @objc    var arrayKey : [String]!
    @objc func accessoryButtonDown(sender : AnyObject){
       
        
        let superView = tableViewp.superview
        
        
        let viewColor = UIColor.lightGray
        imagePopupView.backgroundColor = viewColor.withAlphaComponent(0.5)
        imagePopupView.frame = (superView?.frame)!
        
        //팝업창 배경색
        let baseViewColor = UIColor.white
        
        imagePopupView.baseView.backgroundColor = baseViewColor.withAlphaComponent(0.8)
        imagePopupView.baseView.layer.cornerRadius = 9.0
        imagePopupView.baseView.alpha = 1
        
        superView!.superview!.superview!.addSubview(imagePopupView)
        let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView
        statusBar?.backgroundColor = viewColor.withAlphaComponent(0)
        imagePopupView.isUserInteractionEnabled = true
        
        let allItem = subjectItemStore.subjectAllItems[sender.tag!]
        let imageKey =  allItem.imageKey
        let imageToDisPlay = imageStore.imageForKey(key: imageKey)
        imagePopupView.imageView.image = imageToDisPlay
        
    }
    

}

