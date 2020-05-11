//
//  TbInCollectionInfoViewController.swift
//  TagPicture
//
//  Created by JURA on 2019. 4. 28..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit


class TbInCollectionInfoViewController: UIViewController {
    var actionButton: ActionButton!
    
    var tagStore: TagStore!
    var sqlConnect: SQLConnect!
    var selectedCollectionItem: Int!
    var selectedRow: Int!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var uploadDateLabel: UILabel!
    @IBOutlet var imageUrlLabel: UILabel!
    @IBOutlet var imageSizeLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tagAll = tagStore.tagAll[selectedRow!]
        let itemPhoto = tagAll.photoAll[selectedCollectionItem!]
        titleLabel.text = itemPhoto.title
        idLabel.text = itemPhoto.photoID
        uploadDateLabel.text = itemPhoto.dateTaken
        imageUrlLabel.text = itemPhoto.remoteURL.path
        
        
        var imageData = Data()
        
        do {
            imageData = try Data(contentsOf: itemPhoto.remoteURL)
            
        } catch {
            print("Image Download error!")
        }
        imageView.image = UIImage(data: imageData)
        
        
        let photoRemoveImage = UIImage(named: "photo_remove_icon.png")!
        let tagHomeImage = UIImage(named: "tag_home.png")!
        let tagMove = ActionButtonItem(title: "Go to Home", image: tagHomeImage)
        tagMove.action = { item in
            self.forFirstVC()
            self.actionButton.toggleMenu()
        }
        
        let photoRemove = ActionButtonItem(title: "Remove Photo!", image: photoRemoveImage)
        photoRemove.action = { item in
            self.forFirstVC()
            self.actionButton.toggleMenu()
            print(self.selectedCollectionItem!)
            self.sqlConnect.removePhoto(selectedPhotoId: itemPhoto.photoID)
            
            tagAll.photoAll.remove(at: tagAll.photoAll.index(after: self.selectedCollectionItem! - 1))
            
            
        }
        
        actionButton = ActionButton(attachedToView: self.view, items: [tagMove, photoRemove])
        actionButton.action = { button in button.toggleMenu()
        }
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
    
}
