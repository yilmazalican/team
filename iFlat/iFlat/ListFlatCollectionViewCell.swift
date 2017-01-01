//
//  ListFlatCollectionViewCell.swift
//  iFlat
//
//  Created by Eren AY on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

// Model of ListFlatCollectionViewCell
class ListFlatCollectionViewCell: UICollectionViewCell {
    
    // Variable for flatID of Flat on cell
    var flatID : String = ""
    // Variable for flat Owner of Flat on cell
    var flatOwnerID : String = ""
    // Outlet for flat thumbnail image
    @IBOutlet var flatThumbnail: UIImageView!
    // Outlet for flat title
    @IBOutlet weak var flatTitle: UILabel!
    // Outlet for flat's nightly price
    @IBOutlet weak var flatPrice: UILabel!
    // Outlet for flat's City
    @IBOutlet weak var flatCity: UILabel!
    // Outlet for flat's rating
    @IBOutlet weak var flatRating: UILabel!
    
    // constructor (setter) of class
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
