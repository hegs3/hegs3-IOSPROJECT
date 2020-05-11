//
//  TableViewController.swift
//  TagPicture
//
//  Created by JURA on 2019. 4. 27..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate {
    
    let tableSource = TableViewSource()
    var tagStore: TagStore!
    var sqlConnect: SQLConnect!
    
    var selectedRow: Int!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = tableSource
        tableView.delegate = self
        
        
        tableSource.tagStore = tagStore
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tbInSegue" {
            let tbInCVC = segue.destination as! TbInCollectionViewController
            tbInCVC.tagStore = tagStore
            tbInCVC.sqlConnect = sqlConnect
            tbInCVC.selectedRow = tableView.indexPathForSelectedRow?.row
            print("tbIn ")
        }
    }
}
