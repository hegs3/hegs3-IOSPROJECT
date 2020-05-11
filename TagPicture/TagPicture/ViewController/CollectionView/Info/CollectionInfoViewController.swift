//
//  CollectionInfoViewController.swift
//  TagPicture
//
//  Created by JURA on 2019. 4. 28..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class CollectionInfoViewController: UIViewController {
    var photoStore: PhotoStore!
    var tagStore: TagStore!
    var sqlConnect: SQLConnect!
    
    var actionButton: ActionButton!
    
    @IBOutlet var imageView: UIImageView!
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var uploadDateLabel: UILabel!
    @IBOutlet var imageUrlLabel: UILabel!
    @IBOutlet var imageSizeLabel: UILabel!
    
    @IBOutlet var pickTableContainerView: UIView!
    
  
    var photo: Photo! {
        didSet {
            if (photo.title == ""){
                photo.title = "no subject"
            }
            navigationItem.title = photo.title
            
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:))))
        
        photoStore.fetchImageForPhoto(photo: photo) {
            (result) -> Void in
            self.titleLabel.text = self.photo.title
            self.idLabel.text = self.photo.photoID
            self.uploadDateLabel.text = self.photo.dateTaken.description
            self.imageUrlLabel.text = self.photo.remoteURL.path
            self.imageSizeLabel.text = self.photo.photoSize
            
            switch result {
                case let .Success(image):
                    OperationQueue.main.addOperation {
                        self.imageView.image = image
                    }
                case let .Failure(error):
                    print("Error fetching image Photo:\(error)")
            }
        }
        
        
        
        
        let tagHomeImage = UIImage(named: "tag_home.png")!
        let tagRemoveAllImage = UIImage(named: "photo_remove_all_icon.png")!
        let tagMove = ActionButtonItem(title: "Go to Home", image: tagHomeImage)
        let tagRemoveAll = ActionButtonItem(title: "Remove All!", image: tagRemoveAllImage)
        tagMove.action = { item in
            self.forFirstVC()
            self.actionButton.toggleMenu()
        }
        tagRemoveAll.action = { item in
            self.forFirstVC()
            self.actionButton.toggleMenu()
            self.sqlConnect.removeTagAll()
            self.tagStore.tagAll.removeAll()
        }
        actionButton = ActionButton(attachedToView: self.view, items: [tagMove, tagRemoveAll])
        actionButton.action = { button in button.toggleMenu()}
    }
    
    // TODO: 여기부터 >> 애니메이션 작업까지 한 후 데이터 넣기
    // TODO: ** 아래에서 위로 동작& alpha값 조절 -> container 추가
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if(sender.state == .ended){
            pickTableContainerView.alpha = 0.9
            imageView.isUserInteractionEnabled = false
            self.navigationItem.hidesBackButton = true 
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "pickSegue" {
                let infoVC = segue.destination as! PickTableViewController
                infoVC.photo = photo
                infoVC.tagStore = tagStore
                infoVC.sqlConnect = sqlConnect
                
                
                //여기서 포토데이터 전송 >> pickupTableViewController.photo
            }
        }
}


