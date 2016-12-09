//
//  ListFlatCollectionViewCell.swift
//  iFlat
//
//  Created by Eren AY on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class ListFlatCollectionViewCell: UICollectionViewCell {
    
    
    var flatID : String = ""
    
    @IBOutlet var flatThumbnail: UIImageView!
    @IBOutlet weak var flatTitle: UILabel!
    @IBOutlet weak var flatPrice: UILabel!
    @IBOutlet weak var flatCity: UILabel!
    @IBOutlet weak var flatRating: UILabel!
    
    @IBAction func flatButtonClicked(_ sender: Any) {
        
    }
    
    
    
    
}
