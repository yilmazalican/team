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
    var flatOwnerID : String = ""
    
    @IBOutlet var flatThumbnail: UIImageView!
    @IBOutlet weak var flatTitle: UILabel!
    @IBOutlet weak var flatPrice: UILabel!
    @IBOutlet weak var flatCity: UILabel!
    @IBOutlet weak var flatRating: UILabel!
    
    // constructor
    func setFlatListCell(ID : String, ownerID : String, thumbnail : UIImage, title : String, price : String, city : String, rating : Int){
        flatID = ID
        flatOwnerID = ownerID
        flatThumbnail.image = thumbnail
        flatTitle.text = title
        flatPrice.text = price
        flatCity.text = city
        flatRating.text = String(rating)
    }

}
