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
    var timedFlats = [String]()
    var returningFlats = [FilteredFlat]()
    internal func getFilteredFlats(filter: FilterModel, completion: @escaping ([FilteredFlat]) -> ()) {
        
        var timedFlats = [String]()
        
        FIRREF.instance.getRef().child("timeslots").queryOrderedByKey().queryStarting(atValue: "1481932800").queryEnding(atValue: "1482105600").observe(.value, with: { (ss) in
            for ts in ss.children.allObjects
            {
                let timeslotFlatObj = ts as! FIRDataSnapshot
                let timeslotForFlat = timeslotFlatObj.value as! [String:Bool]
                for x in timeslotForFlat
                {
                    timedFlats.append("-" + x.key)
                }
            }
            
        })
        
        
        FIRREF.instance.getRef().child("filter_flats/" + "dsa").observe(.value, with: { (ss) in
            var MDict = [String:Flat]()
            for i in ss.children.allObjects
            {
                var flt = Flat()
                var flatObject = i as! FIRDataSnapshot
                let mainDict = flatObject.value as! [String:Any]
                flt.id = flatObject.key
                flt.city = filter.city
                flt.title = mainDict["title"] as? String
                flt.userID = mainDict["userId"] as? String
                flt.bathroomCount = mainDict["bathroomCount"] as? Int
                flt.bedCount = mainDict["bedCount"] as? Int
                flt.bedroomCount = mainDict["bedroomCount"] as? Int
                flt.internet = mainDict["internet"] as? Bool
                flt.elevator = mainDict["elevator"] as? Bool
                flt.heating = mainDict["heating"] as? Bool
                flt.gateKeeper = mainDict["gateKeeper"] as?Bool
                flt.parking = mainDict["parking"] as? Bool
                flt.pool = mainDict["pool"] as? Bool
                flt.smoking = mainDict["smoking"] as? Bool
                flt.tv = mainDict["tv"] as? Bool
                flt.flatCapacity = mainDict["capacity"] as? Int
                flt.cooling = mainDict["cooling"] as? Bool
                flt.price = mainDict["price"] as? Double
                flt.washingMachine = mainDict["washingMachine"] as? Bool

                MDict[flt.id] = flt
                
                if((timedFlats).contains(flt.id))
                {
                    if(filter.bathroomCount == nil || filter.bathroomCount! <= flt.bathroomCount!)
                    {
                        if(filter.bedCount == nil || filter.bedCount! <= flt.bedCount!)
                        {
                            if(filter.bedroomCount == nil || filter.bedroomCount! <= flt.bedroomCount!)
                            {
                                if(filter.internet == false || filter.internet! == flt.internet!)
                                {
                                    if(filter.elevator == false || filter.elevator! == flt.elevator!)
                                    {
                                        if(filter.heating == false || filter.heating! == flt.heating!)
                                        {
                                            if(filter.gateKeeper == false || filter.gateKeeper! == flt.gateKeeper!)
                                            {
                                                if(filter.parking == false || filter.parking! == flt.parking!)
                                                {
                                                    if(filter.pool == false || filter.pool! == flt.pool!)
                                                    {
                                                        if(filter.smoking! == false || filter.smoking! == flt.smoking!)
                                                        {
                                                            if(filter.tv! == false || filter.tv! == flt.tv!)
                                                            {
                                                                if(filter.capacity == nil || filter.capacity! <= flt.flatCapacity!)
                                                                {
                                                                    if(filter.cooling == false || filter.cooling! == flt.cooling!)
                                                                    {
                                                                        if(filter.priceFrom == nil || filter.priceFrom! <= flt.price!)
                                                                        {
                                                                            if(filter.priceTo == nil || filter.priceTo! >= flt.price!)
                                                                            {
                                                                                if(filter.washingMachine == false || filter.washingMachine! == flt.washingMachine!)
                                                                                {
                                                                                    let filteredFlat = FilteredFlat(flatID: flt.id, flatThumbnailImage: "", flatTitle: flt.title!, flatCity: flt.city!, flatRating: 0, flatPrice: flt.price!, userID: flt.userID!)
                                                                                    
                                                                                    self.returningFlats.append(filteredFlat)

                                                                                }
                                                                                
                                                                            }
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } //For paranthesis
           completion(self.returningFlats)
            
        })
    }
    
}







class FilteredFlat
{
    var flatID:String
    var flatThumbnailImage:String
    var flatTitle:String
    var flatPrice:Double
    var flatCity:String
    var flatRating:Int
    var userID:String
    
    init(flatID:String, flatThumbnailImage:String, flatTitle:String,flatCity:String,flatRating:Int, flatPrice:Double, userID:String) {
        self.flatID = flatID
        self.flatThumbnailImage = flatThumbnailImage
        self.flatTitle = flatTitle
        self.flatPrice = flatPrice
        self.flatCity = flatCity
        self.flatRating = flatRating
        self.userID = userID
    }

}