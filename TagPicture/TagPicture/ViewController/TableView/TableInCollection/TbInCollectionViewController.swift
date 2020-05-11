//
//  TbInCollectionViewController.swift
//  TagPicture
//
//  Created by JURA on 2019. 4. 28..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class TbInCollectionViewController: UIViewController, UICollectionViewDelegate {
    
    let tbInCollectionViewDataSource = TbInCollectionViewDataSource()
    var actionButton: ActionButton!
    
    
    
    var tagStore: TagStore!
    var sqlConnect: SQLConnect!
    
    var selectedRow: Int!
    
    
    @IBOutlet var tbInCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tbInCollectionView.dataSource = tbInCollectionViewDataSource
        tbInCollectionView.delegate = self
        tbInCollectionViewDataSource.sqlConnect = sqlConnect
        tbInCollectionViewDataSource.tagStore = tagStore
        tbInCollectionViewDataSource.selectedRow = selectedRow
        
        let tagHomeImage = UIImage(named: "tag_home.png")!
        let photoRemoveAllImage = UIImage(named: "photo_remove_all_icon.png")!
        let tagMove = ActionButtonItem(title: "Go to Home", image: tagHomeImage)
        tagMove.action = { item in
            self.forFirstVC()
            self.actionButton.toggleMenu()
        }
        
        let photoRemoveAll = ActionButtonItem(title: "Remove ALL!", image: photoRemoveAllImage)
        photoRemoveAll.action = { item in
            self.forFirstVC()
            self.actionButton.toggleMenu()
            let item = self.tagStore.tagAll[self.selectedRow]
            self.sqlConnect.removePhotoAll(selectedAuth: item.auth)
            item.photoAll.removeAll()
        }
        actionButton = ActionButton(attachedToView: self.view, items: [tagMove, photoRemoveAll])
        actionButton.action = { button in button.toggleMenu()}

    }

    func forFirstVC() {
        guard let  viewController = self.navigationController?.viewControllers else {
            return
        }
        for firstViewController in viewController {
            if firstViewController is MainViewController {
                self.navigationController?.popToViewController(firstViewController, animated: true)
                break
            }
        }
    }
    
    func popToFirstVC() {
        if let topController = navigationController?.topViewController {
            topController.navigationController?.popToViewController(self, animated: true)
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tbInInfoSegue" {
            let tbInCollectionInfoCVC = segue.destination as! TbInCollectionInfoViewController
            tbInCollectionInfoCVC.tagStore = tagStore
            tbInCollectionInfoCVC.sqlConnect = sqlConnect
            tbInCollectionInfoCVC.selectedRow = selectedRow
            
            let indexPaths = tbInCollectionView.indexPathsForSelectedItems
            let indexPath = indexPaths![0] as NSIndexPath
            tbInCollectionInfoCVC.selectedCollectionItem = indexPath.row
            
            
            print("tbInCoIn")
        }
    }
    
 
    
    
}

