//
//  EditPhotoCollectionView.swift
//  iFlat
//
//  Created by Tolga Taner on 29.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class EditPhotoCollectionView: UICollectionView {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
        
    }
   

}


extension EditPhotoCollectionView:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell : EditPhotoCollectionViewCell  = dequeueReusableCell(withReuseIdentifier: EditPhotoCollectionViewCell.cellId, for: indexPath) as? EditPhotoCollectionViewCell {
            
            
          
            
            return cell
            
        }
            
            
        else {
            
            return EditPhotoCollectionViewCell()
            
        }
        
        
        
    }

    
}




