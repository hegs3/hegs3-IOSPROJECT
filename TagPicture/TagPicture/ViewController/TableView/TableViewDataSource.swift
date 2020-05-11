////
////  TableViewDataSource.swift
////  TagPicture
////
////  Created by JURA on 2019. 4. 27..
////  Copyright © 2019년 jura. All rights reserved.
////
//
//import UIKit
//
//class TableViewDataSource: NSObject,UITableViewDataSource {
//    
//    var tagStore: TagStore!
//    var sqlConnect : SQLConnect!
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tagStore.tagAll.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("ggg")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! TableViewCell
//        //       sqlConnect.dictionaryToArray[indexPath.row]
//        let tag = tagStore.tagAll[indexPath.row]
//        
//        
//        tag.line = 0
//        tag.subject = sqlConnect.dictionaryToArray[indexPath.row]
//        
//        cell.tagLabel.text = tag.subject
//        print(tag.subject)
//        
//        return cell
//    }
//    
//    
//    
//
//    
//    
//}
