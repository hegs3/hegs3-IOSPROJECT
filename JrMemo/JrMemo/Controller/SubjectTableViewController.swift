//
//  SubjectTableViewController.swift
//  JrMemo
//
//  Created by JURA on 2019. 1. 2..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit
class SubjectTableViewController: UITableViewController{
    // MARK: property
    var subjectDatasource = SubjectTableViewDatasource()
    var imageStore: ImageStore!
    var folderItem: FolderItem! {
        didSet {
            navigationItem.title = folderItem.folderName
        }
    }
    
    
    // MARK: toolbar Label
    let countLabel: UILabel = {
        let text = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height:CGFloat.greatestFiniteMagnitude))
        text.textAlignment = NSTextAlignment.center
        text.font = UIFont.systemFont(ofSize: 16)
        
        return text
    }()
    
    
    
    // MARK: init()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.rightBarButtonItem = editButtonItem
    }

    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //data input func
        subjectDatasource.subjectItemStore.connect()
        tableView.dataSource = subjectDatasource
        tableView.delegate = self
        subjectDatasource.imageStore = imageStore
        
        //Add to SubView(from: toolbar)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        countLabel.text = "\(subjectDatasource.subjectItemStore.subjectAllItems.count)'s file"
        let count = UIBarButtonItem(customView: countLabel)
        let file = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addSubjectItem(_:)))
        setToolbarItems([flexibleSpace, count,flexibleSpace, file], animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        subjectDatasource.subjectItemStore.save()
    }

    
    // MARK: DataSource
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
     
    
    // MARK: @objc
    @objc func addSubjectItem(_ sender: UIBarButtonItem) {
        let newItem = subjectDatasource.subjectItemStore.createSubjectItem()
        if let index = subjectDatasource.subjectItemStore.subjectAllItems.lastIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            countLabel.text = "\(subjectDatasource.subjectItemStore.subjectAllItems.count)'s file"
            tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }
    }

    
    
    // MARK: prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("test")
        guard let nextController = segue.destination as? ContentDetaileViewController else {
            print("not found Controller")
            return
        }
        guard let row = tableView.indexPathForSelectedRow?.row else {
            print("not found SubjectItem")
            return
        }
        let item = subjectDatasource.subjectItemStore.subjectAllItems[row]
        nextController.subjectItem = item
        nextController.imageStore = imageStore
    }
}
