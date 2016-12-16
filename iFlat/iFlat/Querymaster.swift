//
//  FilteredFlat.swift
//  iFlat
//
//  Created by Alican Yilmaz on 16/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

protocol QuerymasterDelegate :class
{
    func getFilteredFlats(filter:FilterModel, completion: @escaping ([FilteredFlat]) -> ())
}



class Querymaster:QuerymasterDelegate
{
    internal func getFilteredFlats(filter: FilterModel, completion: @escaping ([FilteredFlat]) -> ()) {
        FIRREF.instance.getRef().child("filter_flats" + filter.flatCity!).observe(<#T##eventType: FIRDataEventType##FIRDataEventType#>) { (<#FIRDataSnapshot#>) in
            
        }
    }

    
}


class FilteredFlat
{
    var flatID:String
    var ownerID:String
    var flatThumbnailImage:String
    var flatTitle:String
    var flatPrice:Double
    var flatCity:String
    var flatRating:Int
    
    init(flatID:String, ownerID:String, flatThumbnailImage:String, flatTitle:String,flatCity:String,flatRating:Int, flatPrice:Double) {
        self.flatID = flatID
        self.ownerID = ownerID
        self.flatThumbnailImage = flatThumbnailImage
        self.flatTitle = flatTitle
        self.flatPrice = flatPrice
        self.flatCity = flatCity
        self.flatRating = flatRating
    }
}
