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
    func getFlat(id:String, completion: @escaping (ManipulableFlat?) -> ())
    func addPicture(imgs:[FlatImage], completion: @escaping(String?) -> ())
    func deletePicture(imgs:[FlatImage], completion: @escaping(String?) -> ())
    func getFlatsofUser(userID:String, completion: @escaping ([ManipulableFlat]?) -> ())
    func getFlatofUser(userID:String, flatID:String, completion: @escaping (ManipulableFlat) -> ())
}


class FIRFlat:FIRFlatDelegate
{
    internal func getFlatofUser(userID: String, flatID: String, completion: @escaping (ManipulableFlat) -> ()) {
        FIRREF.instance.getRef().child("user_flats/" + userID + "/" + flatID ).observe(.value, with: { (ss) in

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



    internal func deletePicture(imgs: [FlatImage], completion: @escaping (String?) -> ()) {
        FIRREF.instance.getStorageRef().child("flat_images")
    }

    internal func addPicture(imgs: [FlatImage], completion: @escaping (String?) -> ()) {
        
    }


    

   

    internal func getFlatsofUser(userID: String, completion: @escaping ([ManipulableFlat]?) -> ()) {
        FIRREF.instance.getRef().child("user_flats/" + userID).observe(.value, with: { (ss) in
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
                fltArr.append(flt)
            }
            completion(fltArr)
        })

    }

    
    
    internal func disable(disablingFlat: ManipulableFlat!, completion: @escaping (String?) -> ()) {
        let currentUsrID = FIRAuth.auth()?.currentUser?.uid
        FIRREF.instance.getRef().child("allflat/" +  disablingFlat.id).setValue(true, forKey: "disabled")
        FIRREF.instance.getRef().child("user_flats/" + currentUsrID! + "/" + disablingFlat.id).setValue(true, forKey: "disabled")
        FIRREF.instance.getRef().child("filter_flats/" + disablingFlat.city! + "/" + disablingFlat.id).setValue(true, forKey: "disabled")

    }

   
    internal func edit(newFlt: ManipulableFlat!, completion: @escaping (String?) -> ()) {
        let db_endpoint = FIRUSER()
                db_endpoint.insertFlat(flt: newFlt, completion: { (str) in
                    completion(str)
                })
    }

    
    
    
    internal func getFlat(id: String, completion: @escaping (ManipulableFlat?) -> ()) {
        
        FIRREF.instance.getRef().child("allflats/" + id).observeSingleEvent(of: .value, with: { (snapshot) in
            let flt = Flat()
            let objdict = snapshot.value as! [String:Any]
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
    
    }








