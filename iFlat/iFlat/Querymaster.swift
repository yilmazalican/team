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
    func getPromotions(completion: @escaping ([Promotion]) -> ())
}

/// This class is responsible for querying flats that matched to filter that applied by user, from DB
class Querymaster:QuerymasterDelegate
{
    /// This function gets promotions from DB
    ///
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func getPromotions(completion: @escaping ([Promotion]) -> ()) {

        var promotions = [Promotion]()
        FIRREF.instance().getRef().child("promotions").queryOrdered(byChild: "isActive").queryEqual(toValue: true).observeSingleEvent(of: .value, with: { (ss) in
            for ts in ss.children.allObjects
            {
                let promotionObject = ts as! FIRDataSnapshot
                let object = promotionObject.value as! [String:Any]
                let title = object["title"] as! String
                let discountRate = object["discountRate"] as! Double
                let description = object["description"] as! String
                let isActive = object["isActive"] as! Bool
                let promotion = Promotion(title: title, discountRate: discountRate, description: description, isActive: isActive)
                promotions.append(promotion)
                
            }
            completion(promotions)
        })
        
    }

    var flatEndpoint = FIRFlat()
    
    var returningFlats = [FilteredFlat]()

    /// This function pulls all flats with required timeslot.
    ///
    ///  - Parameter filter: (FilterModel) Applied Search Filter by user
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func getFilteredFlats(filter: FilterModel, completion: @escaping ([FilteredFlat]) -> ()) {
        
        var arr = [String]()
        var zamanAraliginaUygunFlatlar = [String]()
        var a = filter.toDate!.toTimeStamp()
        a  -= (60*60*24)
        
        FIRREF.instance().getRef().child("time_slots").queryOrderedByKey().queryStarting(atValue: String(describing: filter.fromDate!.toTimeStamp())).queryEnding(atValue: String(describing: a)).observeSingleEvent(of: .value, with: { (ss) in
            
            for ts in ss.children.allObjects
            {
                let timeslotFlatObj = ts as! FIRDataSnapshot
                let timeslotForFlat = timeslotFlatObj.value as! [String:Bool]
                for x in timeslotForFlat
                {
                    if (x.value == true)
                    {
                        arr.append(x.key)
                        
                    }
               }               
            }
            let timeSlotRange = (filter.toDate!.toTimeStamp() - filter.fromDate!.toTimeStamp()) / (60*60*24)
            var counts:[String:Int] = [:]
            
            for item in arr {
                counts[item] = (counts[item] ?? 0) + 1
            }
            for (key, value) in counts {
                if(value >= timeSlotRange)
                {
                    zamanAraliginaUygunFlatlar.append(key)
                }
            }
            
            /////////////////////////////////////////////////////////
            //MARK: This method pulls all flats with filtered city.//
            /////////////////////////////////////////////////////////
            
            FIRREF.instance().getRef().child("filter_flats/" + filter.city!).observeSingleEvent(of: .value, with: { (ss) in
                
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
                    flt.address = mainDict["adress"] as? String
                    
                    sehirdekiFlatler[flt.id] = flt
                    
                    if((zamanAraliginaUygunFlatlar).contains(flt.id))
                    {
                        if(filter.bathroomCount == 0 || filter.bathroomCount! <= flt.bathroomCount!)
                        {
                            if(filter.bedCount == 0 || filter.bedCount! <= flt.bedCount!)
                            {
                                if(filter.bedroomCount == 0 || filter.bedroomCount! <= flt.bedroomCount!)
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
                                                                    if(filter.capacity == 0 || filter.capacity! <= flt.flatCapacity!)
                                                                    {
                                                                        if(filter.cooling == false || filter.cooling! == flt.cooling!)
                                                                        {
                                                                            if(filter.priceFrom == 0.0 || filter.priceFrom! <= flt.price!)
                                                                            {
                                                                                if(filter.priceTo == 0.0 || filter.priceTo! >= flt.price!)
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
                else
                {
                    completion(self.returningFlats)
                }
            })
        })
    }
    
    
    
    
}







