//
//  PickTableViewDataSource.swift
//  TagPicture
//
//  Created by JURA on 2019. 5. 7..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class PickTableViewDataSource: NSObject,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "PickTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PickTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("<#T##items: Any...##Any#>, separator: <#T##String#>, terminator: <#T##String#>")
    }
}
