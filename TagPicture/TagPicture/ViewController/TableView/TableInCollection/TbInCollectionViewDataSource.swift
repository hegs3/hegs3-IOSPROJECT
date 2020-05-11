//
//  TbInCollectionViewDataSource.swift
//  TagPicture
//
//  Created by JURA on 2019. 4. 28..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class TbInCollectionViewDataSource:NSObject, UICollectionViewDataSource {
    
    var tagStore: TagStore!
    var sqlConnect:SQLConnect!
    
    var selectedRow: Int!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let item = tagStore.tagAll[selectedRow]
        return item.photoAll.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifire = "TbInCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as! TbInCollectionViewCell
        //TODO : 이미지 출력 하는 작업
        //1. PHOTO를 받아와서 URL로 전송하여 이미지를 출력.
        //2. 이비지를 모바일에 저장하여 저장된 이미지를 출력.(PICK할때 이미지를 따로 저장해야한다.) (var image: UIImage?) 해당이미지 저장 picID로 저장
            //저장된이미지를 picID로 불러온다..
        // 1. URL 이미지 불러오기
        
//        print(sele)
        let item = tagStore.tagAll[selectedRow]
        var imageData = Data()
       
        do {
           imageData = try Data(contentsOf: item.photoAll[indexPath.row].remoteURL)
            
        } catch {
            print("Image Download error!")
        }
        cell.imageView.image = UIImage(data: imageData)
        cell.imageView.image?.draw(in: CGRect(x: 0, y: 0, width: 64, height: 64))
        
        
        return cell

    }
    
}
