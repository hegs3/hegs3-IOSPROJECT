    //
//  CollectionViewDataSource.swift
//  TagPicture
//
//  Created by JURA on 2019. 4. 26..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class CollectionViewDataSource:NSObject, UICollectionViewDataSource {
    var photos = [Photo]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifire = "CollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as! CollectionViewCell
        let photo = photos[indexPath.row]
        cell.updateWithImage(image: photo.image)
        return cell
    }
    
}
