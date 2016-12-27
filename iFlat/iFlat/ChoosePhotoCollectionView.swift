//
//  ChoosePhotoCollectionView.swift
//  iFlat
//
//  Created by Tolga Taner on 28.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class ChoosePhotoCollectionView: UICollectionView {

    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
    }
    
    



}


extension ChoosePhotoCollectionView : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        if let cell : ChoosePhotoCollectionViewCell  = dequeueReusableCell(withReuseIdentifier: ChoosePhotoCollectionViewCell.cellId, for: indexPath) as? ChoosePhotoCollectionViewCell {
            
            
            //cell
            
            
            
            
            return cell
            
        }
        
        
        else {
            
        return ChoosePhotoCollectionViewCell()
            
        }
        
        
        
    }
    
}
