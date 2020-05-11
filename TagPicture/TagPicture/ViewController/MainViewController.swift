//
//  MainViewController.swift
//  TagPicture
//
//  Created by JURA on 2019. 4. 16..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var photoStore : PhotoStore!
    var tagStore: TagStore!
    var actionButton: ActionButton!
    var sqlConnect: SQLConnect!
    
    
    @IBOutlet var collectionContainerView: UIView!
    @IBOutlet var tableContainerView: UIView!
    
    @IBOutlet var photoButtonView: UIButton!
    @IBOutlet var tagButtonView: UIButton!
    @IBOutlet var photoButton: UIButton!
    @IBOutlet var tagButton: UIButton!
    
    
    @IBAction func photoTouchUp(_ sender: Any) {
        
        photoButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        tagButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        photoButtonView.backgroundColor = UIColor.init(red: 118/255.0, green: 169/255.0, blue: 209/255.0, alpha: 1)
        tagButtonView.backgroundColor = UIColor.init(red: 125/255.0, green: 182/255.0, blue: 225/255.0, alpha: 1)
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            self.collectionContainerView.alpha = 0
            self.tableContainerView.alpha = 1
        }, completion: {_ in})
    }
    
    
    @IBAction func tagTouchUp(_ sender: Any) {
        let tv = self.children[0] as! TableViewController
        tv.tableView.reloadData()
        photoButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        tagButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        photoButtonView.backgroundColor = UIColor.init(red: 125/255.0, green: 182/255.0, blue: 225/255.0, alpha: 1)
        tagButtonView.backgroundColor = UIColor.init(red: 118/255.0, green: 169/255.0, blue: 209/255.0, alpha: 1)
        
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            self.collectionContainerView.alpha = 1
            self.tableContainerView.alpha = 0
        }, completion: {_ in})
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TagPhoto"
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
        let photoMoveImage = UIImage(named: "photo_move_icon.png")!
        let tagMoveImage = UIImage(named: "tag_move_icon.png")!
        let photoMove = ActionButtonItem(title: "Go to Tag Photo", image: photoMoveImage)
        photoMove.action = { item in
            self.photoTouchUp((Any).self)
            self.actionButton.toggleMenu()
        }
        let tagMove = ActionButtonItem(title: "Go to Photo tab", image: tagMoveImage)
        tagMove.action = { item in
            self.tagTouchUp((Any).self)
            self.actionButton.toggleMenu()
        }
        actionButton = ActionButton(attachedToView: self.view, items: [photoMove, tagMove])
        actionButton.action = { button in button.toggleMenu()
        }
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableContainerView.alpha = 1
        collectionContainerView.alpha = 0
        tagButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        if (tagButtonView.backgroundColor == UIColor.init(red: 118/255.0, green: 169/255.0, blue: 209/255.0, alpha: 1)){
            tagButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.collectionContainerView.alpha = 1
            self.tableContainerView.alpha = 0
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cvSegue" {
            print("cb")
            let collectionVC = segue.destination as! CollectionViewController
            collectionVC.photoStore = photoStore
            collectionVC.tagStore = tagStore
            collectionVC.sqlConnect = sqlConnect
        }
        if segue.identifier == "tbSegue" {
            let tableVC = segue.destination as! TableViewController
            tableVC.tagStore = tagStore
            tableVC.sqlConnect = sqlConnect
            print("tb")
        }
        
    }
    
    
    
}

//화면 회전 방지(세로모드)
extension UINavigationController {
    open override var shouldAutorotate: Bool {
        return false
    }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
