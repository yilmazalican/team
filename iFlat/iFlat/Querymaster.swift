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
        FIRREF.instance.getRef().child("filter_flats/" + "dsa").observe(.value, with: { (ss) in
            var MDict = [String:Flat]()
            for i in ss.children.allObjects
            {
                var flt = Flat()
                var flatObject = i as! FIRDataSnapshot
                let mainDict = flatObject.value as! [String:Any]
                flt.id = flatObject.key
                flt.bathroomCount = mainDict["bathroomCount"] as? Int
                flt.bedCount = mainDict["bedCount"] as? Int
                flt.cooling = mainDict["cooling"] as? Bool
                flt.bedroomCount = mainDict["bedroomCount"] as? Int
                flt.internet = mainDict["internet"] as? Bool
                flt.elevator = mainDict["elevator"] as? Bool
                flt.flatDescription = mainDict["description"] as? String
                flt.heating = mainDict["heating"] as? Bool
                flt.gateKeeper = mainDict["gateKeeper"] as?Bool
                flt.parking = mainDict["parking"] as? Bool
                flt.pool = mainDict["pool"] as? Bool
                flt.smoking = mainDict["smoking"] as? Bool
                flt.price = mainDict["price"] as? Double
                flt.tv = mainDict["tv"] as? Bool
                flt.washingMachine = mainDict["washingMachine"] as? Bool
                flt.flatCapacity = mainDict["capacity"] as? Int
                flt.title = mainDict["title"] as? String
                MDict[flt.id] = flt
            }
 })
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
