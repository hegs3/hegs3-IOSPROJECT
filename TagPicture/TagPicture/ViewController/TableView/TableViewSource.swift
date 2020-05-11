//
//  TableViewSource.swift
//  TagPicture
//
//  Created by JURA on 2019. 9. 19..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class TableViewSource: NSObject, UITableViewDataSource {
        var tagStore: TagStore!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagStore.tagAll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! TVCell
        
        let tag = tagStore.tagAll[indexPath.row]
        cell.subjectLabel.text = tag.subject
        if !tag.photoAll.isEmpty {
            var imageData = Data()

            do {
                    imageData = try Data(contentsOf: tag.photoAll[0].remoteURL)
            } catch {
                print("Image Download error!")
            }
            cell.checkImage.image = UIImage(data: imageData)
        } else {
            cell.checkImage.image = UIImage(named: "tag_noImage")
        }
        
        if tag.photoAll.isEmpty {
            cell.isUserInteractionEnabled = false
        } else {
            cell.isUserInteractionEnabled = true
            
        }
            return cell
    }
    
}
