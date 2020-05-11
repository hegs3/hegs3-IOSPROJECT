//
//  SettingViewController.swift
//  FontFiner
//
//  Created by JURA on 2020/03/07.
//  Copyright © 2020 jura. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    var uiViews: UIViewS!

    
    
    override func viewDidLoad() {
        //view
        super.viewDidLoad()
        uiViews = UIViewS(frame: self.view.frame)
        uiViews.commonInit("setting")
        uiViews.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        view.addSubview(uiViews)
        
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(didRecieveNotification(_:)),
        name: NSNotification.Name("didBackButtonClick"),
        object: nil)
        
        
    }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(true)
        }
    @objc func didRecieveNotification(_ notification: Notification) {
        self.dismiss(animated: true, completion: nil)
        }

}
