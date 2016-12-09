//
//  ListFlatCollectionViewCell.swift
//  iFlat
//
//  Created by MAC ADMIN on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class ListFlatCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var flatThumbnail: UIButton!
    @IBOutlet weak var flatTitle: UILabel!
    @IBOutlet weak var flatPrice: UILabel!
    @IBOutlet weak var flatCity: UILabel!
    @IBOutlet weak var flatRating: UILabel!
    
    @IBAction func flatButtonClicked(_ sender: Any) {
        
    }
    
    
}
