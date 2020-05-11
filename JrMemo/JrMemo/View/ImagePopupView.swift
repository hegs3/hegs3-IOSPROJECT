   //
//  ImagePopupView.swift
//  JrMemo
//
//  Created by JURA on 2019. 1. 18..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class ImagePopupView: UIView {
    @IBAction func tappeddd(_ sender: Any) {
        
        let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.white.withAlphaComponent(0.8)
                self.removeFromSuperview()
    }
    @IBOutlet var baseView: UIView!
    @IBOutlet var imageView: UIImageView!
    
}
