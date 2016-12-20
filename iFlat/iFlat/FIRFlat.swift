//
//  FIRFlat.swift
//  iFlat
//
//  Created by Alican Yilmaz on 12/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//
import Foundation
import Firebase
import FirebaseStorage
// deletepicture yap!
protocol FIRFlatDelegate :class
{
    func edit(newFlt:ManipulableFlat!, completion: @escaping (String?) -> ())
    func disable(disablingFlat:ManipulableFlat!, completion: @escaping (String?) -> ())
    func getFlatsofUser(userID:String, completion: @escaping ([ManipulableFlat]?) -> ())
    func getFlatofUser(userID:String, flatID:String, completion: @escaping (ManipulableFlat) -> ())
    func getFlatImages(flatID:String, completion: @escaping ([FlatImageDownloaded]?) -> ())
    func setOwnerID() -> String!
    func insertFlat(flt:ManipulableFlat, completion: @escaping (String?) -> ())
    func insertTimeSlot(flt:ManipulableFlat, timeslot:[String], completion: @escaping (String?) -> ())
    
}


class FIRFlat:FIRFlatDelegate
{
    internal func insertTimeSlot(flt: ManipulableFlat, timeslot: [String], completion: @escaping (String?) -> ()) {
        for a in timeslot
        {
            let timeStamp = Date(dateString: a).toTimeStamp()
            FIRREF.instance().getRef().child("time_slots/" + String(timeStamp)).setValue([flt.id: true]) { (err, nil) in
                if err == nil
                {
                    completion(nil)
                }
                else
                {
                    completion(err.debugDescription)
                }
            }
        }
        
        
    }
    internal func insertFlat(flt: ManipulableFlat, completion: @escaping (String?) -> ()) {
        let aFlat = [
            "bathroomCount": flt.bathroomCount!,
            "bedCount" : flt.bedCount!,
            "cooling" : flt.cooling!,
            "bedroomCount" : flt.bedroomCount!,
            "internet" : flt.internet!,
            "elevator" : flt.elevator!,
            "description" : flt.flatDescription!,
            "heating" : flt.heating!,
            "gateKeeper" : flt.gateKeeper!,
            "parking" : flt.parking!,
            "pool" : flt.pool!,
            "smoking" : flt.smoking!,
            "price" : flt.price!,
            "tv" : flt.tv!,
            "washingMachine" : flt.washingMachine!,
            "capacity" : flt.flatCapacity!,
            "disabled": flt.disabled!,
            "userId" : flt.userID,
            "title" : flt.title!] as [String : Any]
        //user_flats
        FIRREF.instance().getRef().child("user_flats/" + flt.userID).child(flt.id).setValue(aFlat) { (err1, nil) in
            if(err1 != nil)
            {
                completion(err1.debugDescription)
                return
            }
            //filter_flats
            FIRREF.instance().getRef().child("filter_flats/" + flt.city!).child(flt.id).setValue(aFlat) { (err2, nil) in
                if err2 != nil
                {
                    completion(err2.debugDescription)
                    return
                }
                //flat_images with non-async way :(
                if flt.images!.count > 0
                {
                    for iterator in flt.images!
                    {
                        let pngREP = UIImagePNGRepresentation(iterator.image)!
                        FIRREF.instance().getStorageRef().child("flat_images" + iterator.id).put(pngREP, metadata: nil, completion: { (mdata, err3) in
                            if err3 != nil
                            {
                                completion(err3.debugDescription)
                                return
                            } else {
                                FIRREF.instance().getRef().child("flat_images/" + flt.id + "/" + iterator.id).setValue(["downloadURL": (mdata!.downloadURL()!.absoluteString)], withCompletionBlock: { (err4, nil) in
                                    if err4 != nil
                                    {
                                        completion(err4.debugDescription)
                                        return
                                    }
                                })
                            }
                        })
                        
                    }
                    completion(nil)
                    
                }
                
            }
            
        }
        
    }
    internal func setOwnerID() -> String! {
        return (FIRAuth.auth()?.currentUser!.uid)
        
    }
    internal func getFlatImages(flatID: String, completion: @escaping ([FlatImageDownloaded]?) -> ()) {
        FIRREF.instance().getRef().child("flat_images/" + flatID).observeSingleEvent(of: .value, with: { (ss) in
            var returningArr = [FlatImageDownloaded]()
            if ss.childrenCount <= 0
            {
                completion(nil)
            }
            else
            {
                for a in ss.children.allObjects
                {
                    let received = a as! FIRDataSnapshot
                    let obje = received.value as! [String:String]
                    let flatimage = FlatImageDownloaded(imageID: received.key, imageDownloadURL: obje["downloadURL"]!)
                    returningArr.append(flatimage)
                    
                }
                completion(returningArr)
            }
            
        })
        
    }
    internal func getFlatofUser(userID: String, flatID: String, completion: @escaping (ManipulableFlat) -> ()) {
        FIRREF.instance().getRef().child("user_flats/" + userID + "/" + flatID ).observe(.value, with: { (ss) in
            let flt = Flat()
            let objdict = ss.value as! [String:Any]
            flt.bathroomCount = objdict["bathroomCount"] as? Int
            flt.bedCount = objdict["bedCount"] as? Int
            flt.cooling = objdict["cooling"] as? Bool
            flt.bedroomCount = objdict["bedroomCount"] as? Int
            flt.internet = objdict["internet"] as? Bool
            flt.elevator = objdict["elevator"] as? Bool
            flt.flatDescription = objdict["description"] as? String
            flt.heating = objdict["heating"] as? Bool
            flt.gateKeeper = objdict["gateKeeper"] as? Bool
            flt.parking = objdict["parking"] as? Bool
            flt.pool = objdict["pool"] as? Bool
            flt.smoking = objdict["smoking"] as? Bool
            flt.price = objdict["price"] as? Double
            flt.tv = objdict["tv"] as? Bool
            flt.washingMachine = objdict["washingMachine"] as? Bool
            flt.flatCapacity = objdict["capacity"] as? Int
            flt.title = objdict["title"] as? String
            completion(flt)
        })
        
    }
    internal func getFlatsofUser(userID: String, completion: @escaping ([ManipulableFlat]?) -> ()) {
        FIRREF.instance().getRef().child("user_flats/" + userID).observe(.value, with: { (ss) in
            var fltArr = [ManipulableFlat]()
            for a in ss.children.allObjects as! [FIRDataSnapshot]
            {
                let flt = Flat()
                let objdict = a.value as! [String:Any]
                flt.id = a.key
                flt.bathroomCount = objdict["bathroomCount"] as? Int
                flt.bedCount = objdict["bedCount"] as? Int
                flt.cooling = objdict["cooling"] as? Bool
                flt.bedroomCount = objdict["bedroomCount"] as? Int
                flt.internet = objdict["internet"] as? Bool
                flt.elevator = objdict["elevator"] as? Bool
                flt.flatDescription = objdict["description"] as? String
                flt.heating = objdict["heating"] as? Bool
                flt.gateKeeper = objdict["gateKeeper"] as? Bool
                flt.parking = objdict["parking"] as? Bool
                flt.pool = objdict["pool"] as? Bool
                flt.smoking = objdict["smoking"] as? Bool
                flt.price = objdict["price"] as? Double
                flt.tv = objdict["tv"] as? Bool
                flt.washingMachine = objdict["washingMachine"] as? Bool
                flt.flatCapacity = objdict["capacity"] as? Int
                flt.title = objdict["title"] as? String
                fltArr.append(flt)
            }
            completion(fltArr)
        })
        
    }
    internal func disable(disablingFlat: ManipulableFlat!, completion: @escaping (String?) -> ()) {
        let currentUsrID = FIRAuth.auth()?.currentUser?.uid
        FIRREF.instance().getRef().child("allflat/" +  disablingFlat.id).setValue(true, forKey: "disabled")
        FIRREF.instance().getRef().child("user_flats/" + currentUsrID! + "/" + disablingFlat.id).setValue(true, forKey: "disabled")
        FIRREF.instance().getRef().child("filter_flats/" + disablingFlat.city! + "/" + disablingFlat.id).setValue(true, forKey: "disabled")
        
    }
    internal func edit(newFlt: ManipulableFlat!, completion: @escaping (String?) -> ()) {
        let db_endpoint = FIRFlat()
        db_endpoint.insertFlat(flt: newFlt, completion: { (str) in
            completion(str)
        })
    }
    
    
    
    
    
}
