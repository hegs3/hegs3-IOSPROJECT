//
//  FolderViewController.swift
//  JrMemo
//
//  Created by JURA on 2018. 12. 30..
//  Copyright © 2018년 jura. All rights reserved.
//

import UIKit

class FolderViewController: UITableViewController {
    // MARK: property
    var folderCellId: String = "FolderCell"
    var folderItemStore: FolderItemStore!
    var imageStore: ImageStore!
    
    
    // MARK: init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelectionDuringEditing = true
        
        //Add to SubView(from: toolbar)
        let addViewSize = CGRect(x: 0, y: 0, width: (navigationController?.toolbar.frame.width)!, height: (navigationController?.toolbar.frame.height)! + 34)
        let addView = UIView(frame: addViewSize)
        addView.backgroundColor = UIColor.white
        addView.alpha = 0.5
        addView.isUserInteractionEnabled = false
        navigationController?.toolbar.addSubview(addView)
    
        //toolbar item create
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFolderItem(_:)))
        setToolbarItems([flexibleSpace, add], animated: true)
        
        //footerView create
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 30))
        footerView.backgroundColor = UIColor.gray
        let footerLabel = UILabel(frame: footerView.frame)
        footerLabel.textColor = UIColor.lightGray
        footerLabel.textAlignment = NSTextAlignment.center
        footerView.addSubview(footerLabel)
        footerLabel.text = "No more folder"
        self.tableView.tableFooterView = footerView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: TableDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderItemStore.folderAllItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: folderCellId, for: indexPath) as! FolderCell
    
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = folderItemStore.folderAllItems[indexPath.row]
            let title = "Delete \(item.folderName!) folder!"
            let message = "Are you sure?"
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing == true {
            let item = folderItemStore.folderAllItems[indexPath.row]
            let title = "Change Folder name"
            let message = "Input new folder name."
            let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            let confirm = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default) { (action) in
                let cell = self.tableView.dequeueReusableCell(withIdentifier: self.folderCellId, for: indexPath) as! FolderCell
                item.folderName = (ac.textFields?[0].text)!
                if item.folderName == ""{
                    item.folderName = "ChangeFolderName"
                }
                cell.folderNameLabel.text = item.folderName
                self.tableView.reloadData()
            }
            ac.addAction(cancel)
            ac.addAction(confirm)
            ac.addTextField { (textField) in
                textField.placeholder = "ChangeFolderName"
                if item.folderName != "ChangeFolderName"{
                    textField.text = item.folderName
                }
                
            }
            present(ac, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "subjectSegue", sender: self)
        }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        folderItemStore.moveFolderItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    // MARK: @objc
    @objc func addFolderItem(_ sender: UIBarButtonItem) {
        let newItem = folderItemStore.createFolderItem()
        if let index = folderItemStore.folderAllItems.lastIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }
    }
    
    
    // MARK: Prepare
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        let storyBoard = self.storyboard!
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "subjectSegue") as!
        SubjectTableViewController
        if let row = tableView.indexPathForSelectedRow?.row {
            let folderItem = folderItemStore.folderAllItems[row]
            nextViewController.folderItem = folderItem
            nextViewController.subjectDatasource.subjectItemStore.folderItem = folderItem
        }
        self.navigationController!.pushViewController(nextViewController, animated: true)
        
        nextViewController.imageStore = imageStore
    }
}
