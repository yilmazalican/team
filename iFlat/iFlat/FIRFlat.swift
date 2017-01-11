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
    func edit(oldcity:String,newFlt:ManipulableFlat!, completion: @escaping (String?) -> ())
    func disable(disablingFlat:ManipulableFlat!, completion: @escaping (String?) -> ())
    func getFlatsofUser(userID:String, completion: @escaping ([ManipulableFlat]?) -> ())
    func getFlatofUser(userID:String, flatID:String, completion: @escaping (ManipulableFlat?) -> ())
    func getFlatImages(flatID:String, completion: @escaping ([FlatImageDownloaded]?) -> ())
    func setOwnerID() -> String!
    func insertFlat(flt:ManipulableFlat, completion: @escaping (String?) -> ())
    func insertTimeSlot(flt:ManipulableFlat, timeslot:[Int], completion: @escaping (String?) -> ())
    func addWishList(fltID:String, completion: @escaping (String?) -> ())
    func deleteWish(flt:ManipulableFlat, completion: @escaping (String?) -> ())
    func getAvailableTimeSlots(flt:ManipulableFlat, completion: @escaping ([Int?]) -> ())
    func deleteFlat(flt:ManipulableFlat,oldcity:String)
    
    
}


class FIRFlat:FIRFlatDelegate
{




    var endp = FIRUSER()
    /// This function deletes flat
    ///
    ///  - Parameter flt: (ManipubleFlat) flat that is wanted to be deleted
    ///  - Parameter oldcity: (String) flats city
    ///  - returns void
    ///  - throws: FIRERROR
    internal func deleteFlat(flt:ManipulableFlat,oldcity: String) {
        FIRREF.instance().getRef().child("filter_flats/" + oldcity + "/" + flt.id).removeValue()
    }

    /// This function gets available time slots of flat from DB
    ///
    ///  - Parameter flt: (ManipubleFlat) Requesting flat
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func getAvailableTimeSlots(flt: ManipulableFlat, completion: @escaping ([Int?]) -> ()) {
        FIRREF.instance().getRef().child("time_slots").queryOrdered(byChild: flt.id).queryEqual(toValue: true).observeSingleEvent(of: .value, with: { (ss) in
            var timeSlots = [Int]()
            for a in ss.children.allObjects
            {
                let received = a as! FIRDataSnapshot
                timeSlots.append(Int(received.key)!)
            }
            completion(timeSlots)
        })
    }

    /// This function deletes wish of flat from DB
    ///
    ///  - Parameter flt: (ManipubleFlat) Requesting flat
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func deleteWish(flt: ManipulableFlat, completion: @escaping (String?) -> ()) {
        
        FIRREF.instance().getRef().child("wishes/" + flt.userID! + "/" + flt.id).removeValue()
        completion(nil)
    }

    /// This function adds wish for flat to DB
    ///
    ///  - Parameter flt: (ManipubleFlat) Requesting flat
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func addWishList(fltID:String, completion: @escaping (String?) -> ()) {
     
        endp.getCurrentLoggedIn { (usr) in
            FIRREF.instance().getRef().child("wishes/" + (usr?.id!)! + "/" + fltID).setValue(true)
            completion(nil)
        }
        
    }

    /// This function inserts time slot to DB for flat
    ///
    ///  - Parameter flt: (ManipubleFlat) Requesting flat
    ///  - Parameter timeslot: ([Int]) Time slot array for flat
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func insertTimeSlot(flt: ManipulableFlat, timeslot: [Int], completion: @escaping (String?) -> ()) {
        for a in timeslot
        {
            FIRREF.instance().getRef().child("time_slots/" + String(a)).setValue([flt.id: true]) { (err, nil) in
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
    /// This function inserts flat to DB
    ///
    ///  - Parameter flt: (ManipubleFlat) Flat to insert
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
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
            "userId" : flt.userID!,
            "city" : flt.city!,
            "address": flt.address!,
            "published": flt.published!,
            "disabled": flt.disabled!,
            "title" : flt.title!] as [String : Any]
        //user_flats
        FIRREF.instance().getRef().child("user_flats/" + flt.userID!).child(flt.id).setValue(aFlat) { (err1, nil) in
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
                if flt.images != nil{
                    if flt.images!.count > 0
                    {
                        for (_,iterator) in (flt.images?.enumerated())!
                        {
                            let pngREP = UIImageJPEGRepresentation(iterator.image, 0.1)
                            FIRREF.instance().getStorageRef().child("flat_images/" + iterator.id + ".jpeg").put(pngREP!, metadata: nil, completion: { (mdata, err3) in
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
        
    }
    /// This function sets ownerID by currentLoggedUser
    ///
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func setOwnerID() -> String! {
        return (FIRAuth.auth()?.currentUser!.uid)
        
    }
    /// This function pulls all images of flat
    ///
    ///  - Parameter flatID: (String) Requesting flat
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
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
    /// This function gets requesting flat by UserID and FlatID
    ///
    ///  - Parameter userID: (String) Flat's owner ID
    ///  - Parameter flatID: (String) Flat ID
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func getFlatofUser(userID: String, flatID: String, completion: @escaping (ManipulableFlat?) -> ()) {
        FIRREF.instance().getRef().child("user_flats/" + userID + "/" + flatID ).observeSingleEvent(of: .value, with: { (ss) in
            if ss.childrenCount >= 1 && userID != "" && flatID != ""{
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
                flt.address = objdict["address"] as? String
                flt.disabled = objdict["disabled"] as? Bool
                flt.published = objdict["published"] as? Bool
                flt.userID = objdict["userId"] as? String
                flt.city = objdict["city"] as? String
                flt.id = ss.key
                completion(flt)
            }
            else
            {
                completion(nil)
            }
            
        })
        
    }
    /// This function pulls all flats of user
    ///
    ///  - Parameter userID: (String) Requesting User ID
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func getFlatsofUser(userID: String, completion: @escaping ([ManipulableFlat]?) -> ()) {
        FIRREF.instance().getRef().child("user_flats/" + userID).queryOrdered(byChild: "disabled").queryEqual(toValue: false).observeSingleEvent(of: .value, with: { (ss) in
            var fltArr = [ManipulableFlat]()
            for a in ss.children.allObjects as! [FIRDataSnapshot]
            {
                let flt = Flat()
                let objdict = a.value as! [String:Any]
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
                flt.address = objdict["address"] as? String
                flt.disabled = objdict["disabled"] as? Bool
                flt.published = objdict["published"] as? Bool
                flt.userID = objdict["userId"] as? String
                flt.city = objdict["city"] as? String
                flt.id = a.key
                fltArr.append(flt)
            }
            completion(fltArr)
        })
        
    }
    /// This function disables flat
    ///
    ///  - Parameter disablingFlat: (ManipubleFlat) Disabling flat
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func disable(disablingFlat: ManipulableFlat!, completion: @escaping (String?) -> ()) {
        FIRREF.instance().getRef().child("user_flats/" + disablingFlat.userID! + "/" + disablingFlat.id + "/disabled").setValue(true)
        FIRREF.instance().getRef().child("filter_flats/" + disablingFlat.city! + "/" + disablingFlat.id + "/disabled").setValue(true)
        completion(nil)
        
    }
    /// This function edits flat
    ///
    ///  - Parameter oldCity: (String) Old city of flat
    ///  - Parameter newFlt: (ManipubleFlat) Edited flat
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func edit(oldcity:String,newFlt: ManipulableFlat!, completion: @escaping (String?) -> ()) {
        let db_endpoint = FIRFlat()
    db_endpoint.deleteFlat(flt: newFlt, oldcity: oldcity)
        db_endpoint.insertFlat(flt: newFlt, completion: { (str) in
            completion(str)
        })
    }
    
    
    
    
    
}
