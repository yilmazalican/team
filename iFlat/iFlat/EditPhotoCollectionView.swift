//
//  EditPhotoCollectionView.swift
//  iFlat
//
//  Created by Tolga Taner on 29.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class EditPhotoCollectionView: UICollectionView {

      var flatImages = [FlatImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
        
    }
   

}


extension EditPhotoCollectionView:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flatImages.count ?? 4
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell : EditPhotoCollectionViewCell  = dequeueReusableCell(withReuseIdentifier: EditPhotoCollectionViewCell.cellId, for: indexPath) as? EditPhotoCollectionViewCell {
            
            
          cell.photoImage.image = flatImages[indexPath.row].image
            
            return cell
            
        }
            
            
        else {
            
            return EditPhotoCollectionViewCell()
            
        }
        
        
        
    }

    
}




