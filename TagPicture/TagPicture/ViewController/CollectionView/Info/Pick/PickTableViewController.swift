//
//  PickTableViewController.swift
//  TagPicture
//
//  Created by JURA on 2019. 5. 7..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class PickTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var tagStore: TagStore!
    var sqlConnect: SQLConnect!
    
    var photo: Photo! {
        didSet {
            if (photo.title == ""){
                photo.title = "no subject"
            }
            navigationItem.title = photo.title
            
        }
    }
    
    var indexPathCon = IndexPath()
    var selectedTableRow: Int!
    var userInteractionEnabled = Bool()
    //textField.resignFirstResponder()
    
    @IBOutlet var pickTableView: UITableView!
    @IBAction func addAction(_ sender: Any) {
    
        let newItem = tagStore.createTag()
        if let index = tagStore.tagAll.lastIndex(of: newItem) {
            
            let indexPath = IndexPath(row: index, section: 0)
            pickTableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            pickTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            sqlConnect.createTag(line: sqlConnect.tagStore.tagAll.count, subject: "ChangeTagName")
        }
    }
    @IBAction func editAction(_ sender: AnyObject) {
                if isEditing {
                    //사용자에게 상태를 알리기 위해 버튼의 텍스트를 변경한다.
                    sender.setTitle("Edit", for: .normal)
                    //편집모드를 끈다
                    setEditing(false, animated: true)
                    self.pickTableView.setEditing(false, animated: true)
                } else {
                    sender.setTitle("Done", for: .normal)
                    //편집모드로 들어간다
                    setEditing(true, animated: true)
                    self.pickTableView.setEditing(true, animated: true)
                }
        if (indexPathCon.isEmpty){
            return
        }
    }
    
    @IBAction func pickAction(_ sender: AnyObject) {
        if selectedTableRow == nil {
            return
        } else {
            let selectedItem = tagStore.tagAll[selectedTableRow]
            selectedItem.photoAll.append(photo)
            //sql에 데이터 저장시키는 작업
            sqlConnect.pickPhoto(selectedAuth: selectedItem.auth, selectedPhoto: photo)
            
            self.navigationController?.popViewController(animated: false)
            self.presentingViewController?.dismiss(animated: false, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
        

    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        pickTableView.allowsSelectionDuringEditing = true
        pickTableView.dataSource = self
        pickTableView.delegate = self

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pickTableView.reloadData()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        pickTableView.reloadData()
    }
    
    
    
    //datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tagStore.tagAll.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickTableViewCell", for: indexPath) as! PickTableViewCell
        
        
        let item = tagStore.tagAll[indexPath.row]
    
        
                cell.pickLabel.text = item.subject
            return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            tableView.cellForRow(at: indexPath)
        }
        let title = "Delete ?"
        let message = "Are you sure you want to delete this item?"
        let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let item = tagStore.tagAll[indexPath.row]
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: UIAlertAction.Style.cancel,
                                         handler: nil)
        let deleteAction = UIAlertAction(title: "Delete",
                                         style: UIAlertAction.Style.destructive,
                                         handler: {
                                            (action) -> Void in
                                            self.tagStore.removeTag(item: item)
                                            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                                            self.sqlConnect.removeTag(auth: item.auth)
        })
        ac.addAction(cancelAction)
        ac.addAction(deleteAction)
        //            //저장소에서 그항목을 제거
        //            itemStroe.removeItem(item: item)
        //            //또한 애니메이션과 함께 테이블 뷰에서 그 행을 제거
        //            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        present(ac, animated: true, completion: nil)
    }
    
    var temp: Int = 0
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tagStore.moveTag(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
        sqlConnect.moveTag()
    }
    
    
    //delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTableRow = indexPath.row
        self.indexPathCon = indexPath
        if tableView.isEditing == true {
            let item = tagStore.tagAll[indexPath.row]
            let title = "Change tag name"
            let message = "Input new tag name."
            let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            let confirm = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default) { (action) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "PickTableViewCell", for: indexPath) as! PickTableViewCell
                item.subject = (ac.textFields?[0].text)!
                if item.subject == ""{
                    item.subject = "ChangeTagName"
                }
                cell.pickLabel.text = item.subject
                tableView.reloadData()

                self.sqlConnect.editTag(auth: item.auth, subject: item.subject)
            }
            ac.addAction(cancel)
            ac.addAction(confirm)
            ac.addTextField { (textField) in
                textField.placeholder = "ChangeTagName"
                if item.subject != "ChangeTagName"{
                    textField.text = item.subject
                }
            }
            present(ac, animated: true, completion: nil)
        }
        
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }


//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//    }
}
