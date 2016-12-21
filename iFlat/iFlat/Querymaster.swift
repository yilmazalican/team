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
    var flatEndpoint = FIRFlat()
    
    var returningFlats = [FilteredFlat]()
    /////////////////////////////////////////////////////////////
    //MARK: This method pulls all flats with required timeslot.//
    /////////////////////////////////////////////////////////////
    internal func getFilteredFlats(filter: FilterModel, completion: @escaping ([FilteredFlat]) -> ()) {
        
        var zamanAraliginaUygunFlatlar = [String]()
        
        FIRREF.instance().getRef().child("time_slots").queryOrderedByKey().queryStarting(atValue: filter.fromDate?.toTimeStamp()).queryEnding(atValue: filter.toDate?.toTimeStamp()).observeSingleEvent(of: .value, with: { (ss) in
            for ts in ss.children.allObjects
            {
                let timeslotFlatObj = ts as! FIRDataSnapshot
                let timeslotForFlat = timeslotFlatObj.value as! [String:Bool]
                for x in timeslotForFlat
                {
                    if (x.value == true && !zamanAraliginaUygunFlatlar.contains(x.key))
                    {
                        zamanAraliginaUygunFlatlar.append(x.key)
                    }
                    
                }
            }
            
            /////////////////////////////////////////////////////////
            //MARK: This method pulls all flats with filtered city.//
            /////////////////////////////////////////////////////////
            
            FIRREF.instance().getRef().child("filter_flats/" + filter.city!).observe(.value, with: { (ss) in
                
                var sehirdekiFlatler = [String:Flat]()
                
                for i in ss.children.allObjects
                {
                    let flt = Flat()
                    let flatObject = i as! FIRDataSnapshot
                    let mainDict = flatObject.value as! [String:Any]
                    flt.userID = (mainDict["userId"] as? String)!
                    flt.id = flatObject.key
                    flt.city = filter.city
                    flt.title = mainDict["title"] as? String
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
                    
                    sehirdekiFlatler[flt.id] = flt
                    
                    if(!(zamanAraliginaUygunFlatlar).contains(flt.id))
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
                                                                                        let filteredFlat = FilteredFlat()
                                                                                        filteredFlat.flatCity = flt.city
                                                                                        filteredFlat.flatID = flt.id
                                                                                        filteredFlat.flatPrice = flt.price
                                                                                        filteredFlat.flatTitle = flt.title
                                                                                        filteredFlat.userID = flt.userID
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
                }
                ////////////////////////////////////////////////////////////////
                //MARK: This method pulls thumbnail image for returning Flats.//
                ////////////////////////////////////////////////////////////////
                if self.returningFlats.count > 0
                {
                    for a in self.returningFlats
                    {
                        FIRREF.instance().getRef().child("flat_images/" + a.flatID!).observeSingleEvent(of: .value, with: { (ss) in
                            let dict = ss.children.allObjects[0] as! FIRDataSnapshot
                            let obj = dict.value as! [String:String]
                            let flatImageDownloaded = FlatImageDownloaded(imageID: dict.key, imageDownloadURL: obj["downloadURL"]!)
                            a.flatThumbnailImage = flatImageDownloaded
                            completion(self.returningFlats)
                        })
                    }
                }
            })
        })
    }
}







