//
//  ColllectionViewController.swift
//  TagPicture
//
//  Created by JURA on 2019. 4. 26..
//  Copyright © 2019년 jura. All rights reserved.
//


//될떄있고 안될떄있음 해결하기

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate {
    var photoStore: PhotoStore!
    var tagStore: TagStore!
    var sqlConnect: SQLConnect!
    
    let collectionViewDataSource = CollectionViewDataSource()
    
    
    @IBOutlet var jam: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = self
        
        photoStore.fetchRecentPhotos() {
            (photosResult) -> Void in
            DispatchQueue.main.async {
                switch photosResult {
                case let .Success(photos):
                    print("Successfully Found \(photos.count) recent photos.")
                    self.collectionViewDataSource.photos = photos
                case let .Failure(error):
                    self.collectionViewDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error)")
                }
                self.collectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = collectionViewDataSource.photos[indexPath.row]
        
        //이미지 데이터를 내려받는다. 시간소요
        photoStore.fetchImageForPhoto(photo: photo) {
            (result) -> Void in
            DispatchQueue.main.async {
                //사진의 인덱스 패스는 요청의 시작과 끝 사이에 변경될 수 있다.
                //따라서 가장 최근의 인덱스 패스를 찾는다
                let photoIndex = self.collectionViewDataSource.photos.lastIndex(of: photo)!
                let photoIndexPath = IndexPath(row: photoIndex, section: 0)
                           
                //요청이 완료될 때 화면에 보이는 셀만 업데이트 한다.
                if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? CollectionViewCell {
                    cell.updateWithImage(image: photo.image)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
            if segue.identifier == "collectionInfoSegue" {
                let infoVC = segue.destination as! CollectionInfoViewController
                let photo = collectionViewDataSource.photos[selectedIndexPath.row]
                infoVC.photo = photo
                infoVC.photoStore = photoStore
                infoVC.tagStore = tagStore
                infoVC.sqlConnect = sqlConnect
            }
        }
    }
    

}



