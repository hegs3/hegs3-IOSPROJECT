//
//  PickTableViewCell.swift
//  TagPicture
//
//  Created by JURA on 2019. 5. 7..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class PickTableViewCell: UITableViewCell {
    
    @IBOutlet var pickLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
